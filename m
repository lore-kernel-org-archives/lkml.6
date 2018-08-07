Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60FA3C46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 15:02:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12E7421502
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 15:02:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rx/6UJbY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12E7421502
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403801AbeHGRRA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 13:17:00 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:44763 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732639AbeHGRQ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 13:16:59 -0400
Received: by mail-io0-f193.google.com with SMTP id q19-v6so14234202ioh.11;
        Tue, 07 Aug 2018 08:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Hes/jFk//nm3wRlygrhCtUFlxzBs1T1pCzOgZfP/2cE=;
        b=rx/6UJbYBChXuLxqt3BVus60E3LlEaAgnHCMH0AL6HBzuCo55sKiTfc8FXOeVCtnJt
         nz+jWyfTsScYdnpkQm1bhD7uLAUP5HCWfk0krFMFMot9/dIKHppx3MrTko6jJdPEkkHM
         CPgiDhB7RFdmlSzAgJrAXS4kyio+yo63XWWBBmS7DTjUwUbtFl02R5Q448J4zmIpvlGN
         CQVdRJhQXjsWvU/OgpH9xnpDBMAtUD1vuoGO43c1XLqMrVfRsLGYEx2qamky4hhp0InC
         X9lxXbHd5W5el1XBazYmWPtHWkUFrgnc8OPGCVh3RSP81QLijxMoKzmmr16eqW6aiHdQ
         S0cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Hes/jFk//nm3wRlygrhCtUFlxzBs1T1pCzOgZfP/2cE=;
        b=V28anvk01Ya9bB203ruEBXZ1CxUcqDkBVUc25Wm3X39cll3W21Q8EpyPDe2bDeE6TD
         YltYwW9A7O/V0+Qst6O0J6+1TDZm5D2xagRspTIesgNzUBfVXDiUOaO/5il2hxlqs/j2
         FqmzvFsx+q9DEOsrKHXKdWcdGVKdH/XyNsutbKjY3aliUP0Qq2j8X6718tpCnSCe/ufF
         Z2837jZ1LOeXiUJuM7fA3CGeisx74shjCILUNVGdtqvUPQ3FdDVvMMomyzb/RCeFvWS/
         AxZC3vUqqrvPatWVEGMhQzL2euKlfVYcQjiAB97QDoI8qbfjVKuQOqc2lf5QzACHa0Sc
         MDuQ==
X-Gm-Message-State: AOUpUlGkNRuEZEu4QJ/K7ZMTWVFy4tI7hlNpSTBO/zeTJLwmP06pq1h2
        6JnNF6F3zAznrKR+qRkrcWlrNCXOnIgfFJwbEv7cO7O+
X-Google-Smtp-Source: AA+uWPzoLawqLi4BHw7StHmlVtJvbFiPdcyYQDvw1cTkOh6y/hIKjHFfdCLAapLnSqmHyW7D2o6suVQWToZBR1YRTm8=
X-Received: by 2002:a5e:8404:: with SMTP id h4-v6mr18462591ioj.171.1533654135642;
 Tue, 07 Aug 2018 08:02:15 -0700 (PDT)
MIME-Version: 1.0
References: <20180807130234.5380-1-yuehaibing@huawei.com>
In-Reply-To: <20180807130234.5380-1-yuehaibing@huawei.com>
From:   Ilya Dryomov <idryomov@gmail.com>
Date:   Tue, 7 Aug 2018 17:02:04 +0200
Message-ID: <CAOi1vP9Gbv-P=HLAKfr=MwPzTDHMpVmexPmf5TJLZhLfSvVttA@mail.gmail.com>
Subject: Re: [PATCH net-next] ceph: remove unnecessary non NULL check for request_key
To:     yuehaibing@huawei.com
Cc:     "David S. Miller" <davem@davemloft.net>,
        "Yan, Zheng" <zyan@redhat.com>, Sage Weil <sage@redhat.com>,
        linux-kernel@vger.kernel.org, netdev <netdev@vger.kernel.org>,
        Ceph Development <ceph-devel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 7, 2018 at 3:03 PM YueHaibing <yuehaibing@huawei.com> wrote:
>
> request_key never return NULL,so no need do non-NULL check.
>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  net/ceph/ceph_common.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/ceph/ceph_common.c b/net/ceph/ceph_common.c
> index 584fdbe..9834edc 100644
> --- a/net/ceph/ceph_common.c
> +++ b/net/ceph/ceph_common.c
> @@ -304,7 +304,7 @@ static int get_secret(struct ceph_crypto_key *dst, const char *name) {
>         struct ceph_crypto_key *ckey;
>
>         ukey = request_key(&key_type_ceph, name, NULL);
> -       if (!ukey || IS_ERR(ukey)) {
> +       if (IS_ERR(ukey)) {
>                 /* request_key errors don't map nicely to mount(2)
>                    errors; don't even try, but still printk */
>                 key_err = PTR_ERR(ukey);

Applied.

Thanks,

                Ilya
