Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751516AbeDFAxq (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 20:53:46 -0400
Received: from smtprelay0114.hostedemail.com ([216.40.44.114]:58903 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751435AbeDFAxp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 20:53:45 -0400
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::,RULES_HIT:41:355:379:541:973:982:988:989:1260:1277:1311:1313:1314:1345:1373:1437:1515:1516:1518:1534:1539:1593:1594:1711:1714:1730:1747:1777:1792:2197:2199:2393:2559:2562:2828:2895:3138:3139:3140:3141:3142:3351:3653:3867:3872:3874:5007:7901:7903:10004:10400:10848:11658:11914:12043:12050:12679:12760:13069:13311:13357:13439:14659:14721:21080:21221:21627:30054:30070:30091,0,RBL:47.151.150.235:@perches.com:.lbl8.mailshell.net-62.8.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:19,LUA_SUMMARY:none
X-HE-Tag: day61_393dc818325f
X-Filterd-Recvd-Size: 1321
Message-ID: <1522976022.11185.53.camel@perches.com>
Subject: git source files with rw permissions
From: Joe Perches <joe@perches.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Date: Thu, 05 Apr 2018 17:53:42 -0700
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some .c source files have r.x permissions (0755) that
should be updated.

A trivial script on a clean git tree like:

$ git ls-files -- "*.[chsS]" | \
  xargs ls -la | \
  grep -P "^[^l](?:.{2,2}x|.{5,5}x|.{8,8}x)" | \
  awk '{print $9}'

today shows:

drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
drivers/net/ethernet/cadence/macb_ptp.c

It would be good to update those via some script like:

$ git ls-files -- "*.[chsS]" | \
  xargs ls -la | \
  grep -P
"^[^l](?:.{2,2}x|.{5,5}x|.{8,8}x)" | \
  awk '{print $9}' | \
  xargs
chmod 644
tmpfile=$(mktemp)
echo "treewide: chmod executable source files
to 0644" > $tmpfile
git commit -s -a -F $tmpfile
rm -f $tmpfile
