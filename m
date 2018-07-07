Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33AFCC6778F
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 03:23:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EACA921E20
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 03:23:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EACA921E20
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933034AbeGGDXX (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 23:23:23 -0400
Received: from mx2.suse.de ([195.135.220.15]:39188 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932965AbeGGDXW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 23:23:22 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5A769AEC6;
        Sat,  7 Jul 2018 03:23:20 +0000 (UTC)
From:   NeilBrown <neilb@suse.com>
To:     Jann Horn <jannh@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Kees Cook <keescook@chromium.org>
Date:   Sat, 07 Jul 2018 13:23:08 +1000
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-doc@vger.kernel.org,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH resend*3] VFS: simplify seq_file iteration code and interface
In-Reply-To: <CAG48ez2yTZMye0W3_5R04bV-Qyaz-=zSiVonw_zvRQNH6dcfeg@mail.gmail.com>
References: <87vacsrt0r.fsf@notabene.neil.brown.name> <87fu3dihtf.fsf@notabene.neil.brown.name> <874lintqa6.fsf@notabene.neil.brown.name> <87y3fcegnn.fsf@notabene.neil.brown.name> <CAG48ez2yTZMye0W3_5R04bV-Qyaz-=zSiVonw_zvRQNH6dcfeg@mail.gmail.com>
Message-ID: <878t6nybj7.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain

On Sat, Jul 07 2018, Jann Horn wrote:

>> @@ -287,11 +278,7 @@ ssize_t seq_read(struct file *file, char __user *buf, size_t size, loff_t *ppos)
>>                 goto Efault;
>>         copied += n;
>>         m->count -= n;
>> -       if (m->count)
>> -               m->from = n;
>> -       else
>> -               pos++;
>> -       m->index = pos;
>> +       m->from = n;
>
> This patch introduces a kernel memory disclosure bug when something
> like the following sequence of events happens (starting from a freshly
> opened seq file):
>
> 1. read(seq_fd, buf, 2000): sets m->from=2000, m->count=100
> 2. create a buffer broken_buf which consists of 1000 bytes writable
> memory followed by unmapped memory
> 3. read(seq_fd, broken_buf, 3100):
>         - flushes buffered data to userspace, result: m->from=2100, m->count=0
>         - accumulates new data, result: m->from=2100, m->count=3050
>         - tries to copy new data to userspace, but fails ("goto Efault")
> 4. read(seq_fd, buf, 4096): does copy_to_user(buf, m->buf + m->from, n)

Thanks for testing and for the report.
I think I see where I went wrong in the patch.
As I said in the description:

  - don't clear ->from when ->count is zero, as ->from is dead when
     ->count is zero.

It is true that ->from is dead when ->count is zero, but as soon as
count becomes non-zero, ->from becomes important again.
So we either need to clear ->from whenever ->count is changed from zero
(which would be clumsy and error prone) we we need to clear
->from somewhere else.

->count is only increased in ->show() calls and there are three ->show()
calls.
- in traverse() ->from is set to zero early, and set once more shortly
  before the function exits, so it is always correct.
- in "we need at least one record in buffer" ->count starts at zero
  so ->from needs to be set to zero as well.
- in "Fill:" ->from is still correct from previous setting.

So I think we just need
	m->from = 0;
at "we need at least one record in buffer".  I'm fairly sure that
will fix the problem you found.  I would appreciate it if you
would test and confirm.
I'll send a patch separately.

Thanks again,
NeilBrown

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAltAMh0ACgkQOeye3VZi
gbmpKhAAv3Djf+u+1/e2BU6ysWor5WboYkyUauN+YqNy+s5zvx3VAiroc9TCqgLP
kjA2P9Ye7d2USH3p/3779Ta0iAe5TOFHLk09JuEu6olf+N9flPa/lAOIWivBycz9
z3Fn2m+P2nvPNSwI6UvK3wTq0GTE9mlMh3qymL+Dt2DyXL9nu9vZ77b+gE9zg8CT
3+kyD8KIaDrXDpvHKjfmYg6vWHozQY9nBZtTWje8wwz4f2R2Ve2fr+zthMowWSnU
mBkqAkPvJPrzqG5MEJTyxhCtoy//44+VXegiP38DC2Xm0RsHMYXHQGSyETJI/IBI
plBmsz43SkZ/psiqLOuOcCHAnDG5E4T0CSO/Y6uazc+wwUbkg6CnBKcSwXFPYpCd
SXzfAF7oApAbwJNQ0rbqJghqo9Z8bvz2v+JroAV3tbQZd8JMmiRcONnKCOh/NThF
ynT0uooi1DYz6pvW+rXomTvu2b+YN/rkCM0qZsLveqp5Qb44Rh+oG+otUqtLhLnO
QlOD47O2Zg0bnR+wm0NbZzUDEBqjmDV2DUbqPVph3Mh21bL9OkwDFnhjQ4OXR4mR
1T+VXxafJ499K3+PbKg6GAgIoNy0ORV4i1gbvHsYM84FoNSY9PpsCrQqg05YRwu5
QG5RfrLYZf/9tH4idKKr5c0FzUGa/pudgND/scEJGKmwNSHDHHg=
=HHdJ
-----END PGP SIGNATURE-----
--=-=-=--
