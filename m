Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC8A9C282C4
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 04:07:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8674B20857
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 04:07:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=digidescorp.com header.i=@digidescorp.com header.b="UWdvB8f7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726796AbfBIEHC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 23:07:02 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:34375 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726222AbfBIEHC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 23:07:02 -0500
Received: by mail-it1-f195.google.com with SMTP id x124so10502194itd.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Feb 2019 20:07:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digidescorp.com; s=google;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=7LZNbZgGlOZ24T8n6zWfi9+M16V+/eb3pxq0kNbN8/k=;
        b=UWdvB8f7wXTs1fxDk9GEu9D3xPwazb72vEcADoosrXbBjt7kilbo3HcPxMIfv3qeoV
         n0Tk8UlLKeU53pHHkE6EleQGtMIJbioSoWgCm3QRT/Ok9J23TGuwtlyLL3n+rEILixgn
         SqzUexU4HI5nfulR7tZ3AnIKLNFpfU9MDI+EA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=7LZNbZgGlOZ24T8n6zWfi9+M16V+/eb3pxq0kNbN8/k=;
        b=PQGcwRCc5HGXq+ix0CBGFysz/4zLUfPQ8FY5rJGZuSqXz8SjXUwIgprdHYiC4j1H6V
         LM1+YEVoMwY7RroYrCnmQON5Wn8tlle6eOBIL61zq1YVqna0d/IJOX5446uo0w77LTNb
         8wFo0pihUTKywlBqjSQl//MqLL6PkXcpUoNOoKlUalleJU0equ+9chwqkaQKEer4ULvl
         pG3CWlolSolnQhf/sQSXiQpKLoMVFvck9tDV0lYP0JY9C30QoG5o1LBmljSugQR40rsu
         S5FPtY/QhwB5dpFyMQQBIyRbIn3eSoIbFzykzRcg+GWGZhbPKO/vVJKcqajuF2z1n0Sp
         lpgQ==
X-Gm-Message-State: AHQUAuauuouevQG3xABrEQmV4xamfUzKesJ2fHw3fJsBlzLHRF9N4atK
        TyN6hve2w6xtPyWPvJ6d+bNSnrvCJrk=
X-Google-Smtp-Source: AHgI3Ib3W0pOo9A6M7MIGf4zrONLxbmJL5OVNBpvw7wmCa1cq7c5HiU9urH2TcJxpxIiLzNRFiaTOQ==
X-Received: by 2002:a02:5b05:: with SMTP id g5mr14160817jab.84.1549685221516;
        Fri, 08 Feb 2019 20:07:01 -0800 (PST)
Received: from [10.10.2.64] (104-51-28-62.lightspeed.cicril.sbcglobal.net. [104.51.28.62])
        by smtp.googlemail.com with ESMTPSA id q12sm295259ioi.54.2019.02.08.20.07.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Feb 2019 20:07:00 -0800 (PST)
Subject: Re: [PATCH 0/2] udf: Fix corrupt on-disk integrity descriptor
 following sync()
From:   Steve Magnani <steve.magnani@digidescorp.com>
To:     jack@suse.com
Cc:     linux-kernel@vger.kernel.org
References: <20190208173455.20151-1-steve@digidescorp.com>
Message-ID: <7ce9c657-efba-5dbb-441d-acb00a13044b@digidescorp.com>
Date:   Fri, 8 Feb 2019 22:06:59 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190208173455.20151-1-steve@digidescorp.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/8/19 11:34 AM, Steve Magnani wrote:
> In cases where the next unique ID or file/directory count of the
> in-core Logical Volume Integrity Descriptor have been updated,
> a sync() causes a (corrupt) LVID with a stale CRC to be written to disk.
>
> Ordinarily, this is corrected by an update of the on-disk LVID that occurs
> when the filesystem is unmounted. However, if power is lost or the
> filesystem resides on a device that is surprise-removed, the corrupt LVID
> remains and can complicate later remounting or fsck/chkdsk.

"Complicate later remounting" turns out to be an understatement.
Actually it seems that this one event can trigger more silent corruption
of the filesystem on future remounts.

The driver will mount without complaint a filesystem that lacks a valid LVID.
But in this scenario, every time lvid_get_unique_id() is called to generate
an ID for a new inode or link, it returns zero. It appears that callers
happily assign this zero to all new inodes or links, with no indication to
the user or in the syslog that a problem is brewing.

I lost the entire contents of a flash disk to what was probably an
instance of this kind of corruption, when I told Windows chkdsk to
repair it.

I'll try to solve that in a separate followon patchset.
The simplest solution I can think of is to force read-only mount when
no LVID is available.

Regards,
------------------------------------------------------------------------
  Steven J. Magnani               "I claim this network for MARS!
  www.digidescorp.com              Earthling, return my space modulator!"

  #include <standard.disclaimer>

