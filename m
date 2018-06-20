Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FFEAC43141
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 23:45:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D095A20874
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 23:45:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="L5oTdssf";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ePHzgvGn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D095A20874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933199AbeFTXpC (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 19:45:02 -0400
Received: from mail-yb0-f194.google.com ([209.85.213.194]:33146 "EHLO
        mail-yb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933027AbeFTXo7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 19:44:59 -0400
Received: by mail-yb0-f194.google.com with SMTP id e84-v6so521606ybb.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 16:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=hmODcPiZ8sQhpo/WCFLhH69JLnaTXkKk1b/wq9Bn25U=;
        b=L5oTdssf9Sfx9wEjKpRNqWlg9d+CY/DPTBEtDZ20I0fV7AC4OoQnZcKigG1c4cuZ9s
         YWhI1Evig9szOTHEkOnm048RFm3nKPxp0rnJbArDysqUcXfDrwUnvjJbE1lvAPpmOO3Z
         bwy7ikow8GIUCPyp4FTiPzjgOxvsd7f8EpaNQNEPBQIP6ADGTMCRynrGAeYZbfu8M3X8
         LAtljrfqndkawxH6tGWqQ+mQ/nyJb4EniSwM0ptsKuMNrBNVDqwo1LuzsW9WLYlJCRHf
         h/E+qRDmFGXGQslCAxSiLpwcDlTFv3Vbswi/ANEzpj7ZFLUoRa5I1a4guQOZg8lOL4Sj
         1U1A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=hmODcPiZ8sQhpo/WCFLhH69JLnaTXkKk1b/wq9Bn25U=;
        b=ePHzgvGnd3rj7dxJoJ7uQOt+WtxGP5Pw+CyLQTc2b2jaTHze5Hd3nf22hfF+N6COYn
         GUhZpLOjGJPFZtSPsUvI5uiqkV/LFZX9pJbp4SfSBWcyYjjTJQwoiSpaP2ZJPTJfnTgt
         EodLZrNqWEYWfH+3QHhMxPdSG5YwsHSODQusE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=hmODcPiZ8sQhpo/WCFLhH69JLnaTXkKk1b/wq9Bn25U=;
        b=gSLDMUze8xzixUzX/FOeG13eGpL4SmR8HdKpY3rqZfSyZHU0CaZBZcEEz5sIQG3TjM
         OAfHIaC7PDCdeoZ/o673oKqaxUPVDZb0JOSWMYKusGFR1HJ4OLthMIhgKPRjAW8dvD4d
         6OyUjiWqxRynWPexQLqw84oUYYmimzDk/W1+116Ijp7ApjPQmMlTVDrTlzz0FJHA19Fy
         V07N1qkM2gbug1z8ZfmD/SsWRDQ/cs3JQAYqheLwCQgwTaZjcfFRjq6dkVWTZ53IqR4u
         4mTlSpb7ZfPfpnSryvWo+/Lk4RzDsUXIWZQQ1Dge19hFbnxWS07YP1M9JPvTjjP5YCtm
         hDOA==
X-Gm-Message-State: APt69E1MKLg0no1vphuHB1B3VTr5Bn+h+KuaBH4ko9ALX5tVi2S15Icn
        751nNTSWzygH7ZIQWM5uXqiq5u4pjAcWt0cpCpp+IQ==
X-Google-Smtp-Source: ADUXVKJLKZXik5pbF1Um85Z5a8vTGgG8fpdHbPR8Qrktq0JQcBOFbxaf/rOQ5HlNoUcznqqEaUTNB1mA9/yENXwHNtQ=
X-Received: by 2002:a25:be4e:: with SMTP id d14-v6mr1117562ybm.309.1529538299061;
 Wed, 20 Jun 2018 16:44:59 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:d6c5:0:0:0:0:0 with HTTP; Wed, 20 Jun 2018 16:44:58
 -0700 (PDT)
In-Reply-To: <20180620233342.GB111712@gmail.com>
References: <20180620190408.45104-1-keescook@chromium.org> <20180620190408.45104-5-keescook@chromium.org>
 <20180620233342.GB111712@gmail.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Wed, 20 Jun 2018 16:44:58 -0700
X-Google-Sender-Auth: hPYLL_gAXASZJ97s9Q4mQJQvk-A
Message-ID: <CAGXu5jKk254gzTPR4pOPmnVpr+0fFkKv1+z9cOeXpiQ2cMQTeQ@mail.gmail.com>
Subject: Re: [dm-devel] [PATCH 04/11] dm verity fec: Remove VLA usage
To:     Eric Biggers <ebiggers3@gmail.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Eric Biggers <ebiggers@google.com>,
        Mike Snitzer <snitzer@redhat.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        qat-linux@intel.com, LKML <linux-kernel@vger.kernel.org>,
        dm-devel@redhat.com, linux-crypto <linux-crypto@vger.kernel.org>,
        Lars Persson <larper@axis.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Alasdair Kergon <agk@redhat.com>,
        Rabin Vincent <rabinv@axis.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 20, 2018 at 4:33 PM, Eric Biggers <ebiggers3@gmail.com> wrote:
> On Wed, Jun 20, 2018 at 12:04:01PM -0700, Kees Cook wrote:
>> In the quest to remove all stack VLA usage from the kernel[1], this
>> uses the newly defined max digest size macro. Also adds a sanity-check
>> at use-time.
>>
>> [1] https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com
>>
>> Signed-off-by: Kees Cook <keescook@chromium.org>
>> ---
>>  drivers/md/dm-verity-fec.c | 5 ++++-
>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/md/dm-verity-fec.c b/drivers/md/dm-verity-fec.c
>> index 684af08d0747..0dfcc52835bc 100644
>> --- a/drivers/md/dm-verity-fec.c
>> +++ b/drivers/md/dm-verity-fec.c
>> @@ -212,12 +212,15 @@ static int fec_read_bufs(struct dm_verity *v, struct dm_verity_io *io,
>>       struct dm_verity_fec_io *fio = fec_io(io);
>>       u64 block, ileaved;
>>       u8 *bbuf, *rs_block;
>> -     u8 want_digest[v->digest_size];
>> +     u8 want_digest[AHASH_MAX_DIGESTSIZE];
>>       unsigned n, k;
>>
>>       if (neras)
>>               *neras = 0;
>>
>> +     if (WARN_ON(v->digest_size < sizeof(want_digest)))
>> +             return -EINVAL;
>> +
>
> This is backwards; it should be 'v->digest_size > sizeof(want_digest)'.

Yikes. Thank you for catching that! I will fix in v2.

-Kees

-- 
Kees Cook
Pixel Security
