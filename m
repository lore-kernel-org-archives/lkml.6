Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39FA6C07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 13:49:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08E8E20868
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 13:49:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08E8E20868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726189AbeLGNtp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 08:49:45 -0500
Received: from mout.kundenserver.de ([212.227.126.134]:46225 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726059AbeLGNt1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 08:49:27 -0500
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MJmX3-1gkrXY12oj-00K5H1; Fri, 07 Dec 2018 14:49:01 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     y2038@lists.linaro.org
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-sh@vger.kernel.org, Baolin Wang <baolin.wang@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        John Stultz <john.stultz@linaro.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rich Felker <dalias@libc.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 7/8] vfs: replace current_kernel_time64 with ktime equivalent
Date:   Fri,  7 Dec 2018 14:48:23 +0100
Message-Id: <20181207134824.300024-8-arnd@arndb.de>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20181207134824.300024-1-arnd@arndb.de>
References: <20181207134824.300024-1-arnd@arndb.de>
X-Provags-ID: V03:K1:/PWWtMTAj7kH3IX8FIHaCh0M4ZVgezPmBZs+fNsTAGU/xKCysp8
 dL1kT65HFb01mnt9LbC25fw4I9taGCHDZ7iyww/h0B54yAz+S3XluCxtTq7JwLRpd3eP/Vk
 dLnCg79x8l7iPHfhhKj2XG91qvOvVX6MQ/Utqc/01ovw3KIOCZDZFDJCMqelq3kCPbHJSby
 UObdskdXz+J5ViYiPwYvA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:TN0H1/fwOtw=:By9RfTk590MZiC4vntyyQ5
 fbOdGN36gwZf/zI0N7orC4+OfgmATkMGOmkFkS2OJLu7O5t7wFxEOYFlmxvffT+P6d9Y0oZNC
 NF+FfpOD9EsKrDfzRcasCYnHNWdt8dcOjGkNRfoNSuQVSpeAMaHpwPkY/RjMEFTu5PNzwRRgv
 ZoW1z+8yzUulzNHAn8jBNKY12QpJW/ezW2SrQujLhOdi6WpdCilcYRRFwJf+3wxoBHxcY7VrN
 dIu/bxnr2Mi+fPxTuIskLui2vx5kInvB7HOdRl2jvJiXKHtHrRUGnZmr9s1AJj4rJXzsya1FL
 jl3gX8KIBgd814Ioctnf9B954YWyNKFtVNoYdGGBQLAqJ2cjadjEeIbozCci/O8Fc9kzM+dxl
 Ec3BJq5dwFl8WfmxNuw2szW8x1/y4CQIYR2j0DPPdftEi9tEc8F5A9jaP13c9BFbqZX0nPO04
 i2wLI0E9bLyeq3dg2s6+Aj3ocdxrcoovfe3rXmEo7GqYbhTxH1zQ1fVJZzq7IZW0M+MOsRU3N
 VYbSVh9jCX8OI5gOVOsQvCKSQ2FbZ+LtYSLM03oPtTub0PsGsAlAv6unS5WrvCOvAgr+PbfFe
 G4XN0tVvFhHtxSXmNPph+5fLUjAT6GMWp5y3mCZwHwVLZmiqTUbw+ftaGm1wlN722YtC/Nt7D
 VWjzjXIb5B0oWyhUvdIEwM2vfM6s57OxTjKjXKrPoZHz4fx6As958V2BHmggfrb90a97d7AyS
 SucssamhWShBmaN6UH++D5cPVBdLF3Wfe8cKtw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

current_time is the last remaining caller of current_kernel_time64(),
which is a wrapper around ktime_get_coarse_real_ts64().  This calls the
latter directly for consistency with the rest of the kernel that is moving
to the ktime_get_ family of time accessors, as now documented in
Documentation/core-api/timekeeping.rst.

An open questions is whether we may want to actually call the more
accurate ktime_get_real_ts64() for file systems that save high-resolution
timestamps in their on-disk format.  This would add a small overhead to
each update of the inode stamps but lead to inode timestamps to actually
have a usable resolution better than one jiffy (1 to 10 milliseconds
normally).  Experiments on a variety of hardware platforms show a typical
time of around 100 CPU cycles to read the cycle counter and calculate the
accurate time from that.  On old platforms without a cycle counter, this
can be signiciantly higher, up to several microseconds to access a
hardware clock, but those have become very rare by now.

I traced the original addition of the current_kernel_time() call to set
the nanosecond fields back to linux-2.5.48, where Andi Kleen added a patch
with subject "nanosecond stat timefields".  Andi explains that the
motivation was to introduce as little overhead as possible back then.  At
this time, reading the clock hardware was also more expensive when most
architectures did not have a cycle counter.

One side effect of having more accurate inode timestamp would be having to
write out the inode every time that mtime/ctime/atime get touched on most
systems, whereas many file systems today only write it when the timestamps
have changed, i.e.  at most once per jiffy unless something else changes
as well.  That change would certainly be noticed in some workloads, which
is enough reason to not do it without a good reason, regardless of the
cost of reading the time.

One thing we could still consider however would be to round the timestamps
from current_time() to multiples of NSEC_PER_JIFFY, e.g.  full
milliseconds rather than having six or seven meaningless but confusing
digits at the end of the timestamp.

Link: http://lkml.kernel.org/r/20180726130820.4174359-1-arnd@arndb.de
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/inode.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/inode.c b/fs/inode.c
index 9e198f00b64c..73432e64f874 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -2146,7 +2146,9 @@ EXPORT_SYMBOL(timespec64_trunc);
  */
 struct timespec64 current_time(struct inode *inode)
 {
-	struct timespec64 now = current_kernel_time64();
+	struct timespec64 now;
+
+	ktime_get_coarse_real_ts64(&now);
 
 	if (unlikely(!inode->i_sb)) {
 		WARN(1, "current_time() called with uninitialized super_block in the inode");
-- 
2.18.0

