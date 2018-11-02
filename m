Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58AF7C0044C
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 02:55:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBF2520657
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 02:55:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="QJyhUODW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBF2520657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726469AbeKBMA5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 08:00:57 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43147 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726229AbeKBMA4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 08:00:56 -0400
Received: by mail-wr1-f66.google.com with SMTP id y3-v6so170792wrh.10
        for <linux-kernel@vger.kernel.org>; Thu, 01 Nov 2018 19:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=ajHK6QwGM4hdUBonR7VE7bp0bFAGXtY98Gw7V4EnCHM=;
        b=QJyhUODW/gvwBQ2W1U8iDLCgEFZx9dimqhhEGNcJnQCON8uJ1i4SNrJMnqFqqtoILL
         c1f4X5QT5mDrFc58tk8lYvCuSlRfoDUiabUwX6VPv93xPW8jacpYVoRvdHQdnOHvs+Cd
         T9HN/akfqp7mjpi6oAlsFYvrXFN7R3QL2C1bQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=ajHK6QwGM4hdUBonR7VE7bp0bFAGXtY98Gw7V4EnCHM=;
        b=U6ODfCzEoqNdS8eHfX5qY2rPVwl2IcVVOziYIQDX2mYJkwwmZIlT1KOJHkZYSQsoTs
         +UDj+AVI/o8d++d8ih/GlcfKtalGGtJ+7v2GaQCYHLIr3v1scLAcLB0rUOhG5+KgGB5z
         KrLVRSFavVamRV7I79IAXL4fKY1F94JykFl04XV1fQZTekufmB5dErKW9wIXcPO2Sl++
         NKmadqAdB44v3f77sJ+Cc9/DzCdDsa4EtN7shd5aDEl2IFW5ZsN2IIPHuQHFFLZ3DLsM
         whMG+WQ3gvdPAAvYkOlP4N/TjkS4wt8e1zrq8bBAwk4Q4FulVsYyf9luhat2zZ+nb/+l
         6Vjw==
X-Gm-Message-State: AGRZ1gKLDS6fCh/9d9JN7VvicnpOmvQ1cli/dCe4MCRo1eGi1840dMwF
        eYrCAEiNgEnE0PjEYV6h1HAW6AHFpK5bbg==
X-Google-Smtp-Source: AJdET5dbqMeZm4UprLqONBBRcEq0SflnDtpE5K6QPEh2iU0Q0WI5COTifW4agUIM1L1wdabptm4WcA==
X-Received: by 2002:a5d:4182:: with SMTP id m2-v6mr9195338wrp.8.1541127324376;
        Thu, 01 Nov 2018 19:55:24 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([209.250.228.18])
        by smtp.gmail.com with ESMTPSA id l67-v6sm58180702wma.20.2018.11.01.19.55.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Nov 2018 19:55:23 -0700 (PDT)
Date:   Fri, 2 Nov 2018 10:55:16 +0800
From:   leo.yan@linaro.org
To:     acme@redhat.com, Jiri Olsa <jolsa@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     Coresight ML <coresight@lists.linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Question: perf dso support for /proc/kallsyms
Message-ID: <20181102025516.GA25374@leoy-ThinkPad-X240s>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10+31 (9cdd884) (2018-06-19)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Now I found that if use the command 'perf script' for Arm CoreSight trace
data, it fails to parse kernel symbols if we don't specify kernel vmlinux
file.   So when we don't specify kernel symbol files then perf tool will
roll back to use /proc/kallsyms for kernel symbols parsing, as result it will
run into below flow:

  thread__find_addr_map(thread, cpumode, MAP__FUNCTION, address, &al);
  map__load(al.map);
  dso__data_read_offset(al.map->dso, machine, offset, buffer, size);
    `-> data_read_offset()

I can observe the function data_read_offset() returns failure, this is caused
by checking the offset sanity "if (offset > dso->data.file_size)"  (I pasted
the whole function code at below in case you want to get more context for it),
but if perf use "/proc/kallsyms" to load kernel symbols, the variable
'dso->data.file_size' will be set to zero thus the sanity checking always
thinks the offset is out of the file size bound.

Now I still don't understand how the dso/map support "/proc/kallsyms" and
have no idea to fix this issue, though I spent some time to look into it.

Could you give some suggestion for this?  Or even better if you have fixing
for this, I am glad to test at my side.

static ssize_t data_read_offset(struct dso *dso, struct machine *machine,
                                u64 offset, u8 *data, ssize_t size)
{
        if (data_file_size(dso, machine))
                return -1;

        /* Check the offset sanity. */
        if (offset > dso->data.file_size)
                return -1;

        if (offset + size < offset)
                return -1;

        return cached_read(dso, machine, offset, data, size);
}

Thanks,
Leo Yan
