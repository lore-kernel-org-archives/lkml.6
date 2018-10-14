Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77EB7C71122
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:32:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BC802087D
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:32:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BC802087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728639AbeJNXNt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 19:13:49 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:36329 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728185AbeJNXMF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 19:12:05 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLs-0004cU-Nx; Sun, 14 Oct 2018 16:30:44 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLW-0000UR-Gz; Sun, 14 Oct 2018 16:30:22 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "David S. Miller" <davem@davemloft.net>,
        "Gopal RajagopalSai" <gopalsr83@gmail.com>,
        "Lance Richardson" <lance.richardson.net@gmail.com>
Date:   Sun, 14 Oct 2018 16:25:41 +0100
Message-ID: <lsq.1539530741.671368479@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 243/366] net: support compat 64-bit time in
 {s,g}etsockopt
In-Reply-To: <lsq.1539530740.755408431@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:cbab:f00:c93f:614
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.60-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Lance Richardson <lance.richardson.net@gmail.com>

commit 988bf7243e03ef69238381594e0334a79cef74a6 upstream.

For the x32 ABI, struct timeval has two 64-bit fields. However
the kernel currently interprets the user-space values used for
the SO_RCVTIMEO and SO_SNDTIMEO socket options as having a pair
of 32-bit fields.

When the seconds portion of the requested timeout is less than 2**32,
the seconds portion of the effective timeout is correct but the
microseconds portion is zero.  When the seconds portion of the
requested timeout is zero and the microseconds portion is non-zero,
the kernel interprets the timeout as zero (never timeout).

Fix by using 64-bit time for SO_RCVTIMEO/SO_SNDTIMEO as required
for the ABI.

The code included below demonstrates the problem.

Results before patch:
    $ gcc -m64 -Wall -O2 -o socktmo socktmo.c && ./socktmo
    recv time: 2.008181 seconds
    send time: 2.015985 seconds

    $ gcc -m32 -Wall -O2 -o socktmo socktmo.c && ./socktmo
    recv time: 2.016763 seconds
    send time: 2.016062 seconds

    $ gcc -mx32 -Wall -O2 -o socktmo socktmo.c && ./socktmo
    recv time: 1.007239 seconds
    send time: 1.023890 seconds

Results after patch:
    $ gcc -m64 -O2 -Wall -o socktmo socktmo.c && ./socktmo
    recv time: 2.010062 seconds
    send time: 2.015836 seconds

    $ gcc -m32 -O2 -Wall -o socktmo socktmo.c && ./socktmo
    recv time: 2.013974 seconds
    send time: 2.015981 seconds

    $ gcc -mx32 -O2 -Wall -o socktmo socktmo.c && ./socktmo
    recv time: 2.030257 seconds
    send time: 2.013383 seconds

 #include <stdio.h>
 #include <stdlib.h>
 #include <sys/socket.h>
 #include <sys/types.h>
 #include <sys/time.h>

 void checkrc(char *str, int rc)
 {
         if (rc >= 0)
                 return;

         perror(str);
         exit(1);
 }

 static char buf[1024];
 int main(int argc, char **argv)
 {
         int rc;
         int socks[2];
         struct timeval tv;
         struct timeval start, end, delta;

         rc = socketpair(AF_UNIX, SOCK_STREAM, 0, socks);
         checkrc("socketpair", rc);

         /* set timeout to 1.999999 seconds */
         tv.tv_sec = 1;
         tv.tv_usec = 999999;
         rc = setsockopt(socks[0], SOL_SOCKET, SO_RCVTIMEO, &tv, sizeof tv);
         rc = setsockopt(socks[0], SOL_SOCKET, SO_SNDTIMEO, &tv, sizeof tv);
         checkrc("setsockopt", rc);

         /* measure actual receive timeout */
         gettimeofday(&start, NULL);
         rc = recv(socks[0], buf, sizeof buf, 0);
         gettimeofday(&end, NULL);
         timersub(&end, &start, &delta);

         printf("recv time: %ld.%06ld seconds\n",
                (long)delta.tv_sec, (long)delta.tv_usec);

         /* fill send buffer */
         do {
                 rc = send(socks[0], buf, sizeof buf, 0);
         } while (rc > 0);

         /* measure actual send timeout */
         gettimeofday(&start, NULL);
         rc = send(socks[0], buf, sizeof buf, 0);
         gettimeofday(&end, NULL);
         timersub(&end, &start, &delta);

         printf("send time: %ld.%06ld seconds\n",
                (long)delta.tv_sec, (long)delta.tv_usec);
         exit(0);
 }

Fixes: 515c7af85ed9 ("x32: Use compat shims for {g,s}etsockopt")
Reported-by: Gopal RajagopalSai <gopalsr83@gmail.com>
Signed-off-by: Lance Richardson <lance.richardson.net@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 net/compat.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/net/compat.c
+++ b/net/compat.c
@@ -386,7 +386,8 @@ static int compat_sock_setsockopt(struct
 	if (optname == SO_ATTACH_FILTER)
 		return do_set_attach_filter(sock, level, optname,
 					    optval, optlen);
-	if (optname == SO_RCVTIMEO || optname == SO_SNDTIMEO)
+	if (!COMPAT_USE_64BIT_TIME &&
+	    (optname == SO_RCVTIMEO || optname == SO_SNDTIMEO))
 		return do_set_sock_timeout(sock, level, optname, optval, optlen);
 
 	return sock_setsockopt(sock, level, optname, optval, optlen);
@@ -451,7 +452,8 @@ static int do_get_sock_timeout(struct so
 static int compat_sock_getsockopt(struct socket *sock, int level, int optname,
 				char __user *optval, int __user *optlen)
 {
-	if (optname == SO_RCVTIMEO || optname == SO_SNDTIMEO)
+	if (!COMPAT_USE_64BIT_TIME &&
+	    (optname == SO_RCVTIMEO || optname == SO_SNDTIMEO))
 		return do_get_sock_timeout(sock, level, optname, optval, optlen);
 	return sock_getsockopt(sock, level, optname, optval, optlen);
 }

