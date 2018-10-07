Return-Path: <SRS0=94iy=MT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEA37C65C1B
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 18:59:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AC5620882
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 18:59:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pzOjpZed"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AC5620882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728065AbeJHCHQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Oct 2018 22:07:16 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35246 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726233AbeJHCHP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Oct 2018 22:07:15 -0400
Received: by mail-pg1-f194.google.com with SMTP id v133-v6so6853167pgb.2;
        Sun, 07 Oct 2018 11:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FiGqnxvEJ/VzphaNAHjZZk6GbNVGrUyYL47E8d/Ynug=;
        b=pzOjpZedhgxCGAU0GLqjByJp1AivGFLvuEgA1jIx7q8At79G9etRusymgsascOdZQw
         +FIB11QfugTZMibed1u1wa3Iy4cKUWJ6raF9m1/kRnVmaZ4YxaasgtwFZyGCelQhyZEE
         UUTRvW8OxoTC8+634FOAAn7J+eVJ3RiVvVdWphUHgUeblPvxE1/ybFGkVHbp6Fl+6R/S
         XPAVQjbbw+h593fM5ESEwYuJgzCtE9YWnra6jgwWIcgMOeZHA+DIJbqKVuMcQDZdQZoh
         k6g7FK7nMO1OidvAJo374GsXma5cCL8X65qVgAh6x/4VZj3Z4cZb8R1VSpU1rttdU2BQ
         /2Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FiGqnxvEJ/VzphaNAHjZZk6GbNVGrUyYL47E8d/Ynug=;
        b=lXjnGV3mKk6ed/nbHI7R6Q9WLQz34Kv4nxEWywBC8BpF4iBxFXUUHqaH8q738KTIWr
         ZvbllFq96dekdF1hgvegCbRThoXPDRLQKnLFrXE7OBrt8jRQjb32FOHgnCa7iAGdeCfj
         HS6HdZhpsR9KWEo6ZuVkO788k2zHgPZ3Q+3t0weGgI//ZJWPkDqBELaEUfP7xkm9xHSA
         EHZYV2YcMKiUtvm0bLnW5LeEU/QBeDX0J8DfjfDTNsLr9OECo1oMU8H2ZYUD4CzXGn45
         S7KrbP8tT2qWGLW/w4HRU83nzeLn9/KRVRUSA8JqWJFLKT6qd567oYiRKLdgZi8fGV/u
         Lo6Q==
X-Gm-Message-State: ABuFfoj6wi45EoTCjtK6R+35LQcrHG/mPKdhYDfJ6gSHin/qV+NTCWoG
        mV1uXV1tarx0YfjGbDTwGsjwwexL/5cScSlyDqTlUA==
X-Google-Smtp-Source: ACcGV61JzjW1OIX7xAUNOssYvk5l9Nbb0fdPBKokXFWnsd5pPZYxiC67v6tkv3grPxIVaRuITpm7aRNXBRvylSGEPWA=
X-Received: by 2002:a62:9402:: with SMTP id m2-v6mr22027765pfe.255.1538938740626;
 Sun, 07 Oct 2018 11:59:00 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1538873915.git.rfreire@redhat.com>
In-Reply-To: <cover.1538873915.git.rfreire@redhat.com>
From:   Steve French <smfrench@gmail.com>
Date:   Sun, 7 Oct 2018 13:58:48 -0500
Message-ID: <CAH2r5muEpTd4xG7oWV5BdA12AOogqscEnFdbUri9C=MFHrN_gQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] CIFS: Info-level log support, print message when
 attempting mount.
To:     rfreire@redhat.com
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Steve French <sfrench@samba.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        Pavel Shilovsky <piastryyy@gmail.com>
Content-Type: multipart/mixed; boundary="000000000000f772d50577a81857"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000f772d50577a81857
Content-Type: text/plain; charset="UTF-8"

Merged into cifs-2.6.git for-next

Made a trivial tab/space correction in the patch (pointed out by
checkpatch) and then added a trivial followon patch to address a
comment/style (trivial)
issue pointed out by checkpatch and to add a little more detailed
comments about generally when to use each debug function.  If any
objections let me know.


On Sun, Oct 7, 2018 at 10:21 AM Rodrigo Freire <rfreire@redhat.com> wrote:
>
> Hi Steve,
> From our conversation over v2, I came out with this v3 patch, which I broke
> in two commits:
>
> * The first commit in cifs_debug.h, creating the cifs_info() function.
>   - The aim of this commit is to allow to the developer to be able to print
>     informational-level data without having to use pr_info, pr_notice etc,
>     in line with other filesystems.
>     . One interesting and noteworthy feature of cifs_info() is that it is
>       transparent to the CIFS_DEBUG config state, either in "y" or "n".
>     . Also, by using KERN_INFO level, it can be safely filtered by a
>       maintainer / administrator, without cluttering their log monitors,
>       since this is a low level alert.
>   - I took the liberty to not add it inside the existing pr_debug, because
>     of the eventual need of some developer to print stuff that should be
>     printed not only in CIFS_DEBUG mode (as there are plenty of pr_notice
>     scattered over the code).
>   - Also, this is not a debug but a info message, so i liked cifs_info()
>     more ;-)
>   - I saw plenty of pr_notice() in CIFS code, but I resisted the urge to
>     convert them to cifs_info().
>
> * The second commit contains the code printing a cifs_info() when attempting
>   a CIFS mount operation.
>
> Appreciate your review.
>
> V3: Created a new cifs_info() function, moved the mount attempt message to
>     cifs_info
>
> V2: Created a loop to select the right cifs_dbg message to be printed,
>     considering the current system's scenario, in order to avoid a
>     duplicate message or stripping out important information in
>     debug.
>
> Rodrigo Freire (2):
>   CIFS: Adds information-level logging function
>   CIFS: Print message when attempting a mount
>
>  fs/cifs/cifs_debug.h | 16 ++++++++++++++++
>  fs/cifs/cifsfs.c     |  7 ++++++-
>  fs/cifs/transport.c  |  2 +-
>  3 files changed, 23 insertions(+), 2 deletions(-)
>
> --
> 1.8.3.1
>


-- 
Thanks,

Steve

--000000000000f772d50577a81857
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-cifs-minor-clarification-in-comments.patch"
Content-Disposition: attachment; 
	filename="0001-cifs-minor-clarification-in-comments.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_jmz8cyrj0>
X-Attachment-Id: f_jmz8cyrj0

RnJvbSA0YzkzOTM0NGY5NGEyNzNhMWVhYjg5Y2Y1OGY3NGM5YWQ2OGE4YThkIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTdGV2ZSBGcmVuY2ggPHN0ZnJlbmNoQG1pY3Jvc29mdC5jb20+
CkRhdGU6IFN1biwgNyBPY3QgMjAxOCAxMzo1MjoxOCAtMDUwMApTdWJqZWN0OiBbUEFUQ0hdIGNp
ZnM6IG1pbm9yIGNsYXJpZmljYXRpb24gaW4gY29tbWVudHMKCkNsYXJpZnkgbWVhbmluZyAoaW4g
Y29tbWVudHMpIG1lYW5pbmcgb2YgdmFyaW91cwpvcHRpb25zIGZvciBkZWJ1ZyBtZXNzYWdlcyBp
biBjaWZzLmtvLiBBbHNvIGZpeGVkCnRyaXZpYWwgZm9ybWF0dGluZy9zdHlsZSBpc3N1ZSB3aXRo
IHByZXZpb3VzIHBhdGNoLgoKU2lnbmVkLW9mZi1ieTogU3RldmUgRnJlbmNoIDxzdGZyZW5jaEBt
aWNyb3NvZnQuY29tPgotLS0KIGZzL2NpZnMvY2lmc19kZWJ1Zy5oIHwgMTIgKysrKysrKysrKysr
CiBmcy9jaWZzL2NpZnNmcy5jICAgICB8ICA2ICsrKystLQogMiBmaWxlcyBjaGFuZ2VkLCAxNiBp
bnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2ZzL2NpZnMvY2lmc19k
ZWJ1Zy5oIGIvZnMvY2lmcy9jaWZzX2RlYnVnLmgKaW5kZXggNzJkYjI5ODdlMDY2Li42MzFkYzFi
YjIxYzEgMTAwNjQ0Ci0tLSBhL2ZzL2NpZnMvY2lmc19kZWJ1Zy5oCisrKyBiL2ZzL2NpZnMvY2lm
c19kZWJ1Zy5oCkBAIC00Nyw2ICs0NywxOCBAQCBleHRlcm4gaW50IGNpZnNGWUk7CiAgKi8KICNp
ZmRlZiBDT05GSUdfQ0lGU19ERUJVRwogCisKKy8qCisgKiBXaGVuIGFkZGluZyB0cmFjZXBvaW50
cyBhbmQgZGVidWcgbWVzc2FnZXMgd2UgaGF2ZSB2YXJpb3VzIGNob2ljZXMuCisgKiBTb21lIGNv
bnNpZGVyYXRpb25zOgorICoKKyAqIFVzZSBjaWZzX2RiZyhWRlMsIC4uLikgZm9yIHRoaW5ncyB3
ZSBhbHdheXMgd2FudCBsb2dnZWQsIGFuZCB0aGUgdXNlciB0byBzZWUKKyAqICAgICBjaWZzX2lu
Zm8oLi4uKSBzbGlnaHRseSBsZXNzIGltcG9ydGFudCwgYWRtaW4gY2FuIGZpbHRlciB2aWEgbG9n
bGV2ZWwgPiA2CisgKiAgICAgY2lmc19kYmcoRllJLCAuLi4pIG1pbm9yIGRlYnVnZ2luZyBtZXNz
YWdlcywgb2ZmIGJ5IGRlZmF1bHQKKyAqICAgICB0cmFjZV9zbWIzXyogIGZ0cmFjZSBmdW5jdGlv
bnMgYXJlIHByZWZlcnJlZCBmb3IgY29tcGxleCBkZWJ1ZyBtZXNzYWdlcworICogICAgICAgICAg
ICAgICAgIGludGVuZGVkIGZvciBkZXZlbG9wZXJzIG9yIGV4cGVyaWVuY2VkIGFkbWlucywgb2Zm
IGJ5IGRlZmF1bHQKKyAqLworCiAvKiBJbmZvcm1hdGlvbiBsZXZlbCBtZXNzYWdlcywgbWlub3Ig
ZXZlbnRzICovCiAjZGVmaW5lIGNpZnNfaW5mb19mdW5jKHJhdGVmdW5jLCBmbXQsIC4uLikJCQlc
CiBkbyB7CQkJCQkJCQlcCmRpZmYgLS1naXQgYS9mcy9jaWZzL2NpZnNmcy5jIGIvZnMvY2lmcy9j
aWZzZnMuYwppbmRleCBkNzhhMzE1NjA5OTUuLjdkZTk2MDNjNTRmMSAxMDA2NDQKLS0tIGEvZnMv
Y2lmcy9jaWZzZnMuYworKysgYi9mcy9jaWZzL2NpZnNmcy5jCkBAIC03MTcsOCArNzE3LDEwIEBA
IGNpZnNfc21iM19kb19tb3VudChzdHJ1Y3QgZmlsZV9zeXN0ZW1fdHlwZSAqZnNfdHlwZSwKIAlz
dHJ1Y3QgY2lmc19tbnRfZGF0YSBtbnRfZGF0YTsKIAlzdHJ1Y3QgZGVudHJ5ICpyb290OwogCi0J
LyogUHJpbnRzIGluIEtlcm5lbCAvIENJRlMgbG9nIHRoZSBhdHRlbXB0ZWQgbW91bnQgb3BlcmF0
aW9uICoKLQkgKglJRiBDSUZTX0RFQlVHICYmIGNpZnNfRllJICovCisJLyoKKwkgKiBQcmludHMg
aW4gS2VybmVsIC8gQ0lGUyBsb2cgdGhlIGF0dGVtcHRlZCBtb3VudCBvcGVyYXRpb24KKwkgKglJ
ZiBDSUZTX0RFQlVHICYmIGNpZnNfRllJCisJICovCiAJaWYgKGNpZnNGWUkpCiAJCWNpZnNfZGJn
KEZZSSwgIkRldm5hbWU6ICVzIGZsYWdzOiAlZFxuIiwgZGV2X25hbWUsIGZsYWdzKTsKIAllbHNl
Ci0tIAoyLjE3LjEKCg==
--000000000000f772d50577a81857--
