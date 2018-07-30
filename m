Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 994AA16256E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 16:30:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51FE920870
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 16:30:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51FE920870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731803AbeG3SGQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 14:06:16 -0400
Received: from smtprelay0155.hostedemail.com ([216.40.44.155]:44162 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726760AbeG3SGQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 14:06:16 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id A8D0918002DA9;
        Mon, 30 Jul 2018 16:30:30 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: sort01_215e07653f716
X-Filterd-Recvd-Size: 3882
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf11.hostedemail.com (Postfix) with ESMTPA;
        Mon, 30 Jul 2018 16:30:29 +0000 (UTC)
Message-ID: <15f7c81085d98709dc38fa6d14694f893d6101e6.camel@perches.com>
Subject: Re: checkpatch: SPDX integration breaks --root
From:   Joe Perches <joe@perches.com>
To:     Charlemagne Lasse <charlemagnelasse@gmail.com>
Cc:     Rob Herring <robh@kernel.org>, Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Mon, 30 Jul 2018 09:30:27 -0700
In-Reply-To: <CAFGhKby698K852CWEh3zF_cqoumCgnv7OXLXrN2L9s-E4knBnA@mail.gmail.com>
References: <CAFGhKbzXiAx3iaveOQhXCseH2kg1U=j-sp0B9jNSF2wPUjDtFg@mail.gmail.com>
         <14f411527d551411defdd73a2507a13b7f07e789.camel@perches.com>
         <CAFGhKby698K852CWEh3zF_cqoumCgnv7OXLXrN2L9s-E4knBnA@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-07-30 at 17:52 +0200, Charlemagne Lasse wrote:
> > Does this work for you:
> > ---
> >  scripts/checkpatch.pl | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> > index f25f708cd2a7..f0e6913c5cc1 100755
> > --- a/scripts/checkpatch.pl
> > +++ b/scripts/checkpatch.pl
> > @@ -852,7 +852,7 @@ sub is_maintained_obsolete {
> >  sub is_SPDX_License_valid {
> >         my ($license) = @_;
> > 
> > -       return 1 if (!$tree || which("python") eq "" || !(-e "$root/scripts/spdxcheck.py"));
> > +       return 1 if (!$tree || which("python") eq "" || !(-e "$root/scripts/spdxcheck.py") || !(-e "$root/.git"));
> > 
> >         my $status = `echo "$license" | python $root/scripts/spdxcheck.py -`;
> >         return 0 if ($status ne "");
> 
> No, because $root is a git repository in my case (linux-next to be
> exact). The problem here is that spdxcheck is ignoring $root and just
> assumes that cwd is a linux git repository. And when it is one but not
> a linux git repo then I get following error:
> 
> FAIL: "Blob or Tree named 'other' not found"
> Traceback (most recent call last):
>   File "/usr/src/linux-next/scripts/spdxcheck.py", line 234, in <module>
>     spdx = read_spdxdata(repo)
>   File "/usr/src/linux-next/scripts/spdxcheck.py", line 41, in read_spdxdata
>     for el in lictree[d].traverse():
>   File "/usr/lib/python2.7/dist-packages/git/objects/tree.py", line
> 298, in __getitem__
>     return self.join(item)
>   File "/usr/lib/python2.7/dist-packages/git/objects/tree.py", line 244, in join
>     raise KeyError(msg % file)
> KeyError: "Blob or Tree named 'other' not found"
> 
> 
> Still, your change looks good when $root is pointing to an extracted
> tarball with the linux sources and not to a full repository

OK. How about:

though this might not work on a path with spaces
or some such...

---
 scripts/checkpatch.pl | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index f25f708cd2a7..afb9fb27908c 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -852,9 +852,10 @@ sub is_maintained_obsolete {
 sub is_SPDX_License_valid {
 	my ($license) = @_;
 
-	return 1 if (!$tree || which("python") eq "" || !(-e "$root/scripts/spdxcheck.py"));
+	return 1 if (!$tree || which("python") eq "" || !(-e "$root/scripts/spdxcheck.py") || !(-e "$root/.git"));
 
-	my $status = `echo "$license" | python $root/scripts/spdxcheck.py -`;
+	my $root_path = abs_path($root);
+	my $status = `cd $root_path; echo "$license" | python scripts/spdxcheck.py -`;
 	return 0 if ($status ne "");
 	return 1;
 }
