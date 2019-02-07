Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84638C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 20:51:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B86F2146E
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 20:51:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727591AbfBGUvh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 15:51:37 -0500
Received: from icebox.esperi.org.uk ([81.187.191.129]:42044 "EHLO
        mail.esperi.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727471AbfBGUvh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 15:51:37 -0500
Received: from loom (nix@sidle.srvr.nix [192.168.14.8])
        by mail.esperi.org.uk (8.15.2/8.15.2) with ESMTP id x17K8V1F017784;
        Thu, 7 Feb 2019 20:08:31 GMT
From:   Nix <nix@esperi.org.uk>
To:     Coly Li <colyli@suse.de>
Cc:     linux-bcache@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, Dave Chinner <david@fromorbit.com>,
        Andre Noll <maan@tuebingen.mpg.de>
Subject: Re: bcache on XFS: metadata I/O (dirent I/O?) not getting cached at all?
References: <87h8dgefee.fsf@esperi.org.uk>
        <64f32487-5b8f-f6c2-37a9-84bb0717a9e1@suse.de>
Emacs:  ballast for RAM.
Date:   Thu, 07 Feb 2019 20:51:26 +0000
In-Reply-To: <64f32487-5b8f-f6c2-37a9-84bb0717a9e1@suse.de> (Coly Li's message
        of "Thu, 7 Feb 2019 16:16:48 +0800")
Message-ID: <87k1ib8gq9.fsf@esperi.org.uk>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-DCC--Metrics: loom 1102; Body=6 Fuz1=6 Fuz2=6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7 Feb 2019, Coly Li uttered the following:
> On 2019/2/7 6:11 上午, Nix wrote:
>> As it is, this seems to render bcache more or less useless with XFS,
>> since bcache's primary raison d'etre is precisely to cache seeky stuff
>> like metadata. :(
>
> Hi Nix,
>
> Could you please to try whether the attached patch makes things better ?

Looks good! Before huge tree cp -al:

loom:~# bcache-stats 
stats_total/bypassed: 1.0G
stats_total/cache_bypass_hits: 16
stats_total/cache_bypass_misses: 26436
stats_total/cache_hit_ratio: 46
stats_total/cache_hits: 24349
stats_total/cache_miss_collisions: 8
stats_total/cache_misses: 27898
stats_total/cache_readaheads: 0

After:

stats_total/bypassed: 1.1G
stats_total/cache_bypass_hits: 16
stats_total/cache_bypass_misses: 27176
stats_total/cache_hit_ratio: 43
stats_total/cache_hits: 24443
stats_total/cache_miss_collisions: 9
stats_total/cache_misses: 32152           <----
stats_total/cache_readaheads: 0

So loads of new misses. (A bunch of bypassed misses too. Not sure where
those came from, maybe some larger sequential reads somewhere, but a lot
is getting cached now, and every bit of metadata that gets cached means
things get a bit faster.)


btw I have ported ewheeler's ioprio-based cache hinting patch to 4.20;
I/O below the ioprio threshold bypasses everything, even metadata and
REQ_PRIO stuff. It was trivial, but I was able to spot and fix a tiny
bypass accounting bug in the patch in the process): see
http://www.esperi.org.uk/~nix/bundles/bcache-ioprio.bundle. (I figured
you didn't want almost exactly the same patch series as before posted to
the list, but I can do that if you prefer.)


Put this all together and it seems to work very well: my test massive
compile triggered 500MiB of metadata writes at the start and then the
actual compile (being entirely sequential reads) hardly wrote anything
out and was almost entirely bypassed: meanwhile a huge git push I ran at
idle priority didn't pollute the cache at all. Excellent!

(I'm also keeping write volumes down by storing transient things like
objdirs that just sit in the page cache and then get deleted on a
separate non-bcached, non-journalled ext4 fs at the start of the the
spinning rust disk, with subdirs of this fs bind-mounted into various
places as needed. I should make the scripts that do that public because
they seem likely to be useful to bcache users...)


Semi-unrelated side note: after my most recent reboot, which involved a
bcache journal replay even though my shutdown was clean, the stats_total
reset; the cache device's bcache/written and
bcache/set/cache_available_percent also flipped to 0 and 100%,. I
suspect this is merely a stats bug of some sort, because the boot was
notably faster than before and cache_hits was about 6000 by the time it
was done. bcache/priority_stats *does* say that the cache is "only" 98%
unused, like it did before. Maybe cache_available_percent doesn't mean
what I thought it did.

-- 
NULL && (void)
