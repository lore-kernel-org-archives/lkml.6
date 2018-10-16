Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FORGED_MUA_MOZILLA,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D472FC04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 12:55:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D1C4204FD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 12:55:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="IREuc/KC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D1C4204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727078AbeJPUqI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 16:46:08 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:49535 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726781AbeJPUqI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 16:46:08 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20181016125545euoutp02df2f8d330ebca45ada0a3fc63c8f3b08~eGAgP4_TN0299402994euoutp02Q
        for <linux-kernel@vger.kernel.org>; Tue, 16 Oct 2018 12:55:45 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20181016125545euoutp02df2f8d330ebca45ada0a3fc63c8f3b08~eGAgP4_TN0299402994euoutp02Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1539694545;
        bh=ozxWc4RrK5HQyZu9fpakx1cbiyZOPWxEObo7vsqhsQY=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=IREuc/KCplxA26htdHgQO2vHbg9j/ey+LC4KPgEV6vAu0UE9fzEk46pIYl5TGcJ1l
         rumGRmTwJEGpdBrvei5PkBU8k/fOnhQGGrUQCGi8B0rBm0+XFfnkBuuBMg3s81hdIj
         GF1g74sRv0zrPbeFwcYNaM5vPKUZrm/hubbLF2NQ=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20181016125544eucas1p2dd3503efb4c37676d1bfa5aaf7ad54b8~eGAfNLAZP3181531815eucas1p2D;
        Tue, 16 Oct 2018 12:55:44 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 3D.BF.04441.0DFD5CB5; Tue, 16
        Oct 2018 13:55:44 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20181016125543eucas1p1f23b3482179a9cd465f509e0abf782c1~eGAecmAv93038330383eucas1p1j;
        Tue, 16 Oct 2018 12:55:43 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20181016125543eusmtrp2c1b69653371a86b1bad9c4e63eb89e13~eGAeN6L_L3242932429eusmtrp2g;
        Tue, 16 Oct 2018 12:55:43 +0000 (GMT)
X-AuditID: cbfec7f2-a1ae89c000001159-db-5bc5dfd0c93c
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 8C.18.04128.FCFD5CB5; Tue, 16
        Oct 2018 13:55:43 +0100 (BST)
Received: from [106.120.43.17] (unknown [106.120.43.17]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20181016125542eusmtip1260bf3fca54c61e86c6b2817194c71c5~eGAdyH43K2906629066eusmtip1A;
        Tue, 16 Oct 2018 12:55:42 +0000 (GMT)
Subject: Re: [PATCH 1/3] driver core: add probe_err log helper
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Javier Martinez Canillas <javierm@redhat.com>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Mark Brown <broonie@kernel.org>
From:   Andrzej Hajda <a.hajda@samsung.com>
Date:   Tue, 16 Oct 2018 14:55:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
        Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <605bd00e-ed0d-4259-bdc3-1784b2b3b16a@samsung.com>
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0gUYRSG+3Z2Z2fNtXG9HSwKtwwqdDWCBizNMFiErD9BZFFTTqu4q7bT
        rpmFpim23VbJ0lEzsVQs8W5qrYL3rMTUMgUv5YYkiJqKl+jiOEb+e3jPec95z8dHYIpaiSsR
        FnGZ0UfQWiVuI65pW+ry6B5pDfaaWZBS383NiCrPKJVQ6V+sOJWYX4pTeQ8LEVUx9klC9dZn
        41RJy5CUyplLxw7J1HXckFRdUXwLVzfmvJCqK5/GqacaPuLqe1XFSD1bsfW49JTNgRBGG2Zk
        9Crfczah2RNfRVGpbldMi50oHk2BCREEkPsgn3M3IRmhIIsQ3FneY0I2KzyHoLtuAQmFWQSp
        367xzPdbuWRc0AsRLPbsFwyTCJa7OBFfcCB9YbasVWxCUsKRVEGjkW/ByDQMLN3Dq16c3AW/
        KgdWWUy6w3hvK8azE3kSWkbzVvfKSXt4k2kV8zllpB+MdvjyMkZug8TqLExgFxi05or4+UB2
        SaHJ8lIieI3Q+K4WFzIHwPyN0TV2gIn2KqnAW+BPXa5I4DhIyOzDhEEpCDryC9cMPtDc/kHC
        h8BWQpfWqwTZHxpKLZjwhnbwedJeyGMHaTWP1mQ5pCQrhG43GHlfjQnsAs+653EzUnLrjuTW
        Xcatu4z7v/cJEhcjF8bA6jQM6x3BRHuytI41RGg8L0TqKtDKf3r7u/1HLZrvOd+ESAIpbeWL
        /S3BCgltZGN0TQgITOko1/S0BivkIXTMVUYfeVZv0DJsE9pMiJUu8oLH5cEKUkNfZsIZJorR
        /6uKCJlrPEowtgRuvx42He4lGz9cePN1xo7+Bruovapo6sGRwIDmuVcy6/OgvjMbLariNk36
        QUyUfWLgaIonXTJvmLF4JDktlY1pY6P884fMY85Bg7Z3bTsdejc4+J12pu2HTZvqdtajn7cr
        jyXFXhrM7JgysfFckRrrMhf41NyfvphVbi5RitlQ2ns3pmfpv0S5k5JLAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrLIsWRmVeSWpSXmKPExsVy+t/xu7rn7x+NNvjxStDi5YTDjBYbZ6xn
        tZj68AmbRfPi9WwWC6ctZ7TY9Pgaq8XlXXPYLNYeuctuMffLVGYHTo+ds+6ye2xa1cnmsX/u
        GnaPzUvqPd7vu8rm0bdlFaPH501yAexRejZF+aUlqQoZ+cUltkrRhhZGeoaWFnpGJpZ6hsbm
        sVZGpkr6djYpqTmZZalF+nYJehlzXj1iKpioWNH14xRjA+N7iS5GTg4JAROJJ7Pa2LoYuTiE
        BJYySjS8nsIKkRCX2D3/LTOELSzx51oXVNFrRolFHy+DJYQF7CQ+bzjK0sXIziEioC+xvwwk
        yiwwjVni/GxdiPKtTBLbPi1kB0mwCWhK/N18E2gOBwcvUOvvnSUgYRYBVYnnl4+CTRQViJBY
        vfwF2Am8AoISJ2c+YQEp5xSwl3hwwg5ivLrEn3mXmCFseYnmrbOhbHGJW0/mM01gFJqFpHsW
        kpZZSFpmIWlZwMiyilEktbQ4Nz232EivODG3uDQvXS85P3cTIzAqtx37uWUHY9e74EOMAhyM
        Sjy8P64fiRZiTSwrrsw9xCjBwawkwpt+6Wi0EG9KYmVValF+fFFpTmrxIUZToN8mMkuJJucD
        E0ZeSbyhqaG5haWhubG5sZmFkjjveYPKKCGB9MSS1OzU1ILUIpg+Jg5OqQbGvdfu9dVWTvF4
        6XxKv7BZ6J/st7UfnnVf3vbxb+LemQp3Drq/SDRO21//Xu684Q6D3zlnLq4Xe3E5V09Rm13+
        sqN+7r19v7MOJRpevnxv3WyB/dvNF1595Svp9uX2qbeFIRne9h3MBUWtTa0Lxa12cLq9uDsj
        pF/+3aXzTS8m6Bq7R6epWttPU2Ipzkg01GIuKk4EALaAQu3gAgAA
Message-Id: <20181016125543eucas1p1f23b3482179a9cd465f509e0abf782c1~eGAecmAv93038330383eucas1p1j@eucas1p1.samsung.com>
X-CMS-MailID: 20181016125543eucas1p1f23b3482179a9cd465f509e0abf782c1
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20181016072249eucas1p2303b8c06a9f7c839a971fe065b0c752e
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181016072249eucas1p2303b8c06a9f7c839a971fe065b0c752e
References: <CGME20181016072249eucas1p2303b8c06a9f7c839a971fe065b0c752e@eucas1p2.samsung.com>
        <20181016072244.1216-1-a.hajda@samsung.com>
        <20181016072244.1216-2-a.hajda@samsung.com>
        <CAHp75VfVxEkTzc=1hBrvc4K7r=L28vXipb=j9jSRJbTJE4GtLQ@mail.gmail.com>
        <605bd00e-ed0d-4259-bdc3-1784b2b3b16a@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16.10.2018 13:29, Andrzej Hajda wrote:
> On 16.10.2018 13:01, Andy Shevchenko wrote:
>> On Tue, Oct 16, 2018 at 10:22 AM Andrzej Hajda <a.hajda@samsung.com> wrote:
>>> During probe every time driver gets resource it should usually check for error
>>> printk some message if it is not -EPROBE_DEFER and return the error. This
>>> pattern is simple but requires adding few lines after any resource acquisition
>>> code, as a result it is often omited or implemented only partially.
>>> probe_err helps to replace such code seqences with simple call, so code:
>>>         if (err != -EPROBE_DEFER)
>>>                 dev_err(dev, ...);
>>>         return err;
>>> becomes:
>>>         return probe_err(dev, err, ...);
>>>
>>> Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
>>> ---
>>>  drivers/base/core.c    | 37 +++++++++++++++++++++++++++++++++++++
>>>  include/linux/device.h |  2 ++
>>>  2 files changed, 39 insertions(+)
>>>
>>> diff --git a/drivers/base/core.c b/drivers/base/core.c
>>> index 04bbcd779e11..23fabefb217a 100644
>>> --- a/drivers/base/core.c
>>> +++ b/drivers/base/core.c
>>> @@ -3067,6 +3067,43 @@ define_dev_printk_level(_dev_info, KERN_INFO);
>>>
>>>  #endif
>>>
>>> +/**
>>> + * probe_err - probe error check and log helper
>>> + * @dev: the pointer to the struct device
>>> + * @err: error value to test
>>> + * @fmt: printf-style format string
>>> + * @...: arguments as specified in the format string
>>> + *
>>> + * This helper implements common pattern present in probe functions for error
>>> + * checking: print message if the error is not -EPROBE_DEFER and propagate it.
>>> + * It replaces code sequence:
>>> + *     if (err != -EPROBE_DEFER)
>>> + *             dev_err(dev, ...);
>>> + *     return err;
>>> + * with
>>> + *     return probe_err(dev, err, ...);
>>> + *
>>> + * Returns @err.
>>> + *
>>> + */
>>> +int probe_err(const struct device *dev, int err, const char *fmt, ...)
>>> +{
>>> +       struct va_format vaf;
>>> +       va_list args;
>>> +
>>> +       if (err != -EPROBE_DEFER) {
>> Why not
>>
>> if (err == ...)
>>  return err;
>>
>> ...
>> return err;
>>
>> ?
>>
>> Better to read, better to maintain. No?
> Yes, anyway next patch will re-factor it anyway.
>
>>> +               va_start(args, fmt);
>>> +
>>> +               vaf.fmt = fmt;
>>> +               vaf.va = &args;
>>> +
>>> +               __dev_printk(KERN_ERR, dev, &vaf);
>> It would be nice to print an error code as well, wouldn't it?
> Hmm, on probe fail error is printed anyway (with exception of
> EPROBE_DEFER, ENODEV and ENXIO):
>     "probe of %s failed with error %d\n"
> On the other side currently some drivers prints the error code anyway
> via dev_err or similar, so I guess during conversion to probe_err it
> should be removed then.
>
> If we add error code to probe_err is it OK to report it this way?
>     dev_err(dev, "%V, %d\n", &vaf, err);

Ups, I forgot that message passed to probe_err will contain already
newline character.
So the err must be before message passed to probe_err, for example:
    dev_err(dev, "err=%d: %V\n", err, &vaf);
Is it OK? Or better leave this part of the patch as is?

Regards
Andrzej

>
> Regards
> Andrzej
>
>>> +               va_end(args);
>>> +       }
>>> +
>>> +       return err;
>>> +}
>>> +
>>>  static inline bool fwnode_is_primary(struct fwnode_handle *fwnode)
>>>  {
>>>         return fwnode && !IS_ERR(fwnode->secondary);
>>> diff --git a/include/linux/device.h b/include/linux/device.h
>>> index 90224e75ade4..06c2c797d132 100644
>>> --- a/include/linux/device.h
>>> +++ b/include/linux/device.h
>>> @@ -1577,6 +1577,8 @@ do {                                                                      \
>>>         WARN_ONCE(condition, "%s %s: " format, \
>>>                         dev_driver_string(dev), dev_name(dev), ## arg)
>>>
>>> +int probe_err(const struct device *dev, int err, const char *fmt, ...);
>>> +
>>>  /* Create alias, so I can be autoloaded. */
>>>  #define MODULE_ALIAS_CHARDEV(major,minor) \
>>>         MODULE_ALIAS("char-major-" __stringify(major) "-" __stringify(minor))
>>> --
>>> 2.18.0
>>>

