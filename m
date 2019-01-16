Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90337C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 18:58:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51D2020868
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 18:58:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fCadf8Jd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729961AbfAPS6C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 13:58:02 -0500
Received: from mail-qt1-f175.google.com ([209.85.160.175]:46160 "EHLO
        mail-qt1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728926AbfAPS6B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 13:58:01 -0500
Received: by mail-qt1-f175.google.com with SMTP id y20so8378331qtm.13
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 10:58:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=uvIs70O3qRA1NMDZcp8RUJ2MmdYk3fT1LOw+0q0p6fo=;
        b=fCadf8JdnWP5QU4Yxno9eiYq/ha+LYNgK7kOwn6KlXy1bU45UbBlplnBByD/29Vpa0
         pAhOmKrh79/Tcmv6TQT/y3JFDyBKErEQdJNeQ9kJL0IwtSpN4N/vkwhhmCyj9zZbtuIA
         18UCzkO9CwOJ2LEpyUkhI/jDEVAaqcvCzcTOU2IiTOGfNtujIcxEoyMvAmwhAoyKSqIs
         5p+HO/qnyn6qo7okaTbb3++OJOl2zvQi4YVWPy0VSY5nq44pce9j3eZWnW4ymCRp9uRv
         PCdQFlkR2d1xAqJMFhwo6oI+cJqoUnCpnPTnE0nqJtUUJii4r1HYCT2QS55TZ/aMGDtH
         h+jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=uvIs70O3qRA1NMDZcp8RUJ2MmdYk3fT1LOw+0q0p6fo=;
        b=bgjyPssHEfHjMbnB78UR9lEScVwzc1p6HN/8Ub83V0orIyBVoSseuujB68HMR3zbp2
         4itVSvynTfweSVdrg5Hnm76Cy0Acih3sJDrzMzz6RJgu+r4q7rRAcA4uIs3f1HNkSf2Y
         NP7xe+KkJDjJtqw0TfD26Et9MG42fyVV8GzFIWtKW0RQvpluT+t4/STpuSO9JUDMTqYY
         bXZmDlmzAeTWSfBVCiJp+0fPpnHSpYBNsWeJnH3E8KhZYR90bJIcaTqAWv/tUGa/pyy1
         fJnU9+QDVKuwwVmNoQP8JmINaKHshEuexIR2PcYSNcLcgGSQ54nZZuzWWFDGfPy5beVq
         njkg==
X-Gm-Message-State: AJcUukf46xIoQHrV88qf1FSCevLwvGMzlz3ArHkX6AsWv3F3b25yJBvY
        yfilc963QM+12IEG+R4efV+iM/0YmjENtqIVTE4gAOlD
X-Google-Smtp-Source: ALg8bN6eM9dxasCh7TD04W5jxHePByErDgRY4j+nC9WJRW2/xEPMqvxylcXoDg40rzDVhjy5Gi1ggPhFIQyqL8EiaFQ=
X-Received: by 2002:ac8:1889:: with SMTP id s9mr8103919qtj.268.1547665080645;
 Wed, 16 Jan 2019 10:58:00 -0800 (PST)
MIME-Version: 1.0
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Wed, 16 Jan 2019 10:57:49 -0800
Message-ID: <CAPhsuW4EiGUo=p=KYsu+kGWVFRoxEjF3Bq_32QvakQjCsAAjFQ@mail.gmail.com>
Subject: perf segfault in in ordered_events__free()
To:     open list <linux-kernel@vger.kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     acme@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

We are debugging a segfault of perf in ordered_events__free().
Disassemble shows the segfault was caused by oe->buff == NULL
in the following line:

        /*
         * Current buffer might not have all the events allocated
         * yet, we need to free only allocated ones ...
         */
        list_del(&oe->buffer->list);

After poking around the code, I suspect it is caused by the following
condition in alloc_event():

        } else if (oe->buffer) {
                new = &oe->buffer->event[oe->buffer_idx];
                if (++oe->buffer_idx == MAX_SAMPLE_BUFFER)
                        oe->buffer = NULL;

Does this theory make sense? If so, what would be the best fix?

Thanks in advance!
Song
