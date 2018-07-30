Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C483160A325
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 15:41:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B70E20893
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 15:41:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B70E20893
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726828AbeG3RQg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 13:16:36 -0400
Received: from smtprelay0183.hostedemail.com ([216.40.44.183]:48426 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726651AbeG3RQf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 13:16:35 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id E820B815C;
        Mon, 30 Jul 2018 15:41:02 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: nerve56_260a06c2ee443
X-Filterd-Recvd-Size: 2453
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf12.hostedemail.com (Postfix) with ESMTPA;
        Mon, 30 Jul 2018 15:41:01 +0000 (UTC)
Message-ID: <14f411527d551411defdd73a2507a13b7f07e789.camel@perches.com>
Subject: Re: checkpatch: SPDX integration breaks --root
From:   Joe Perches <joe@perches.com>
To:     Charlemagne Lasse <charlemagnelasse@gmail.com>
Cc:     Rob Herring <robh@kernel.org>, Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Mon, 30 Jul 2018 08:40:59 -0700
In-Reply-To: <CAFGhKbzXiAx3iaveOQhXCseH2kg1U=j-sp0B9jNSF2wPUjDtFg@mail.gmail.com>
References: <CAFGhKbzXiAx3iaveOQhXCseH2kg1U=j-sp0B9jNSF2wPUjDtFg@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-07-30 at 10:53 +0200, Charlemagne Lasse wrote:
> Hi,
> 
> I am now getting python errors when using --root with checkpatch.pl
> and not being inside the linux repository.
> 
> $ ./linux-next/scripts/checkpatch.pl --root=/usr/src/linux-next
> --strict -f linux-next/Makefile
> FAIL: /usr/src
> Traceback (most recent call last):
>  File /usr/src/linux-next/scripts/spdxcheck.py", line 230, in <module>
>    repo = git.Repo(os.getcwd())
>  File "/usr/lib/python2.7/dist-packages/git/repo/base.py", line 156, in __init__
>    raise InvalidGitRepositoryError(epath)
> InvalidGitRepositoryError: /usr/src
> 
> total: 0 errors, 0 warnings, 0 checks, 1726 lines checked
> 
> linux-next/Makefile has no obvious style problems and is ready for submission.

Does this work for you:
---
 scripts/checkpatch.pl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index f25f708cd2a7..f0e6913c5cc1 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -852,7 +852,7 @@ sub is_maintained_obsolete {
 sub is_SPDX_License_valid {
 	my ($license) = @_;
 
-	return 1 if (!$tree || which("python") eq "" || !(-e "$root/scripts/spdxcheck.py"));
+	return 1 if (!$tree || which("python") eq "" || !(-e "$root/scripts/spdxcheck.py") || !(-e "$root/.git"));
 
 	my $status = `echo "$license" | python $root/scripts/spdxcheck.py -`;
 	return 0 if ($status ne "");
