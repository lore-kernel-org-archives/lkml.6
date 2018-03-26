Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752106AbeCZU3B (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 16:29:01 -0400
Received: from smtprelay0232.hostedemail.com ([216.40.44.232]:54904 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751157AbeCZU27 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 16:28:59 -0400
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::,RULES_HIT:41:355:379:541:967:973:982:988:989:1260:1277:1311:1313:1314:1345:1373:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2525:2559:2563:2682:2685:2828:2859:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3352:3653:3865:3866:3867:3868:3870:3871:3872:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:5007:6119:7903:8985:9025:10004:10400:10848:11657:11658:11914:12043:12295:12760:12895:13069:13311:13357:13439:14181:14394:14659:14721:21080:21433:21627:30051:30054,0,RBL:47.151.150.235:@perches.com:.lbl8.mailshell.net-62.8.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:33,LUA_SUMMARY:none
X-HE-Tag: mint13_1412dd4c45f3d
X-Filterd-Recvd-Size: 1969
Message-ID: <1522096136.12357.21.camel@perches.com>
Subject: [PATCH script] hwmon: Use octal not symbolic permissions
From: Joe Perches <joe@perches.com>
To: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>
Cc: linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
        patches@opensource.cirrus.com
Date: Mon, 26 Mar 2018 13:28:56 -0700
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/hwmon is the most frequent user of symbolic permissions
like S_IRUGO in the kernel tree.

$ git grep -w -P "S_[A-Z]{5,5}" | \
  cut -f1 -d: | cut -f1-2 -d"/" | sed -r 's/[A-Za-z0-9_-]+\.[ch]$//' | \
  sort | uniq -c | sort -rn | head
   3862 drivers/hwmon
    814 drivers/scsi
    763 drivers/net
    242 drivers/infiniband
    184 drivers/staging
    181 drivers/usb
    158 fs/proc
    150 fs/xfs
    148 fs/
    142 drivers/misc

But using octal and not symbolic permissions is preferred by many
as it can be more readable.

https://lkml.org/lkml/2016/8/2/1945

Rather than converting these piecemeal, perhaps just do them all
at once via a trivial script like the below:

$ git grep -w -P --name-only "S_[A-Z]{5,5}" drivers/hwmon | \
  xargs ./scripts/checkpatch.pl -f --types=symbolic_perms --fix-inplace
$ git grep -w -P --name-only "S_[A-Z]{5,5}" drivers/hwmon | \
  xargs ./scripts/checkpatch.pl -f --types=symbolic_perms --fix-inplace

It's run twice because checkpatch only does 1 conversion per line
and there are some multiple instance lines.

This currently results in a 669 KB patch which is too large
to post but can be easily generated when appropriate.
