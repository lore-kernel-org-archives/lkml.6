Return-Path: <SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZrd/ZmZE14Fj5+snxMBfA2d66KVIMEQNWGzaVtOOkMVmWQTVEvH1pfzos+M3dnCuUtH06d2
ARC-Seal: i=1; a=rsa-sha256; t=1526631501; cv=none;
        d=google.com; s=arc-20160816;
        b=AliqVkgGdqXJFZVcz89BsLql2oDIXcOjmZEkNTGD0iIq8ZfpBgEfosir2yiUUCiKW1
         TrGTiOsqD3s/VfO1t0tLOGrwZkqaYhJVxDOxPTRNXcaj8VP+16dVfbWdE9Vq1MSXKzTd
         /VJM3Eedtn/SWxyVSOyra0KFNqMdHz/JAnP8NK9TofQSP2S3zkPrjnahw8Mjkaxif5dO
         hvNLp/HuLMYTX5Ganv7YX7NYQl33aoEr2rOglVYG8nLjmjPlgzQSgH4qJWWUTXMk90hh
         1nw+r4fmHtcC1vyN/c2IKZpPxfAhC8ZAxyOEmi1i+yGTajyxj9zkSjNM4ae7SbAZ9ukE
         C5FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=PSbw6/zi5zCJ9jFjCSxpB1PjO0Ikmrbz/onN7mOm8p8=;
        b=o20X1O+5gP8vUvSg7je/t2SKtjPVeCLjEGaQzfE79ZBky02BnCx4BCja7OZ8X4I7qD
         lNvIcYgdRDTagFM4r53SXtw8WRLM6PpRnYw4jQRSOaeILhdnY5VYcf+/OiRc5nc6JUkP
         6+FYhf+jA/k4O1Or3o1E6Lccl9rA30FpXX/IE1tpEojCKJRiUZ74VCyND8PMs6Fqqub3
         eolayVre+gildvnFp3f4bRMcUjEn7e1xXkDQN5f4pIbGi1mdSYOCKEdbXd5+kb+p2t3y
         bjU6/eQkeDp/wVG6A53i+QjTV7zqHGX8w1nECe44+TYYu9UiBhY+6ktRqW4RJxy4sqAf
         vbFA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=logOCk+c;
       spf=pass (google.com: domain of srs0=xuy6=if=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=logOCk+c;
       spf=pass (google.com: domain of srs0=xuy6=if=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Gopal RajagopalSai <gopalsr83@gmail.com>,
	Lance Richardson <lance.richardson.net@gmail.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.16 16/55] net: support compat 64-bit time in {s,g}etsockopt
Date: Fri, 18 May 2018 10:15:12 +0200
Message-Id: <20180518081458.265799303@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180518081457.428920292@linuxfoundation.org>
References: <20180518081457.428920292@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600789153242990673?=
X-GMAIL-MSGID: =?utf-8?q?1600789153242990673?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lance Richardson <lance.richardson.net@gmail.com>

[ Upstream commit 988bf7243e03ef69238381594e0334a79cef74a6 ]

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/compat.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/net/compat.c
+++ b/net/compat.c
@@ -377,7 +377,8 @@ static int compat_sock_setsockopt(struct
 	    optname == SO_ATTACH_REUSEPORT_CBPF)
 		return do_set_attach_filter(sock, level, optname,
 					    optval, optlen);
-	if (optname == SO_RCVTIMEO || optname == SO_SNDTIMEO)
+	if (!COMPAT_USE_64BIT_TIME &&
+	    (optname == SO_RCVTIMEO || optname == SO_SNDTIMEO))
 		return do_set_sock_timeout(sock, level, optname, optval, optlen);
 
 	return sock_setsockopt(sock, level, optname, optval, optlen);
@@ -442,7 +443,8 @@ static int do_get_sock_timeout(struct so
 static int compat_sock_getsockopt(struct socket *sock, int level, int optname,
 				char __user *optval, int __user *optlen)
 {
-	if (optname == SO_RCVTIMEO || optname == SO_SNDTIMEO)
+	if (!COMPAT_USE_64BIT_TIME &&
+	    (optname == SO_RCVTIMEO || optname == SO_SNDTIMEO))
 		return do_get_sock_timeout(sock, level, optname, optval, optlen);
 	return sock_getsockopt(sock, level, optname, optval, optlen);
 }
