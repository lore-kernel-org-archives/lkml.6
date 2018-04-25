Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/WFsk9GJi609iCakkc5VNt5WXRx8sIHHz21c8VQXmkU4QcxPH9hD9ymNFHMlNlzFFnDZAO
ARC-Seal: i=1; a=rsa-sha256; t=1524653033; cv=none;
        d=google.com; s=arc-20160816;
        b=P93ezC6crI3ILky0K+3zY2rXLSMiDIn9SoYMwjoEtZ83YN439IP85cXNGtW17GHHO7
         0WAms16cs+vEdlvMmEl3OdxnvVY2tzTjNjdbVlXwoog2DwQdCY5eXI0TEeTH8WyavgdV
         eU2OykhAQi2fJ//uFI8IIb+PGoAOCI4drmW2qq9dDHR1cskiwEGq0Ebj4/Z4cfpDideP
         pi/J3cEu1yKNKNexSSgCmJXKkAuQ15tNMrZMuN/dCh0GpheA7J51gdMk3KYHoTfCdw+1
         zXX/Eq+b0r6TQocPXouFkRge2GLTngUf18i+kEYTJvQn6Itgb4A8MnR2tTUpE/GR20c6
         NlXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=zAI7xYbKXpiZyDdGERLn6tl5ol9+JbghutCCVWvWUQo=;
        b=vNbkBZRwazytoTyD9Jgik3EW8KJ0yNtsKrvt5VvpdTD/+JF/p4GNyfjCtO8TYzZnVL
         RTe5BQa0v/oNS5Ncb5Ul0xJreXxvKSwCQcq1UsgpdpoCzybaW6EcRujGJ76K5wWIrKQq
         jzVU6gOlD5iM0LouVn7f29UgqYY8A93TE3/HsEOxjotgN6lYYgwsHwpZxiOV6RF9b6cO
         W014cXiXw0EDPSMKjKKpIKpYfgoO6sBw+hnCiBoyamGSzZSo2VNcXHMmrOTsTJctoib1
         COKeX3dxB4/EF3rEUtXXtwG+pODe5kUwMfb7fPVGkpSpdJKiEPHzOG20VdXNWTeHYY2K
         prOg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Naresh Kamboju <naresh.kamboju@linaro.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 160/183] bpf: fix rlimit in reuseport net selftest
Date: Wed, 25 Apr 2018 12:36:20 +0200
Message-Id: <20180425103248.962678024@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180425103242.532713678@linuxfoundation.org>
References: <20180425103242.532713678@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598714578698222826?=
X-GMAIL-MSGID: =?utf-8?q?1598714578698222826?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Daniel Borkmann <daniel@iogearbox.net>


[ Upstream commit 941ff6f11c020913f5cddf543a9ec63475d7c082 ]

Fix two issues in the reuseport_bpf selftests that were
reported by Linaro CI:

  [...]
  + ./reuseport_bpf
  ---- IPv4 UDP ----
  Testing EBPF mod 10...
  Reprograming, testing mod 5...
  ./reuseport_bpf: ebpf error. log:
  0: (bf) r6 = r1
  1: (20) r0 = *(u32 *)skb[0]
  2: (97) r0 %= 10
  3: (95) exit
  processed 4 insns
  : Operation not permitted
  + echo FAIL
  [...]
  ---- IPv4 TCP ----
  Testing EBPF mod 10...
  ./reuseport_bpf: failed to bind send socket: Address already in use
  + echo FAIL
  [...]

For the former adjust rlimit since this was the cause of
failure for loading the BPF prog, and for the latter add
SO_REUSEADDR.

Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
Link: https://bugs.linaro.org/show_bug.cgi?id=3502
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/testing/selftests/net/reuseport_bpf.c |   21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

--- a/tools/testing/selftests/net/reuseport_bpf.c
+++ b/tools/testing/selftests/net/reuseport_bpf.c
@@ -21,6 +21,7 @@
 #include <sys/epoll.h>
 #include <sys/types.h>
 #include <sys/socket.h>
+#include <sys/resource.h>
 #include <unistd.h>
 
 #ifndef ARRAY_SIZE
@@ -190,11 +191,14 @@ static void send_from(struct test_params
 	struct sockaddr * const saddr = new_any_sockaddr(p.send_family, sport);
 	struct sockaddr * const daddr =
 		new_loopback_sockaddr(p.send_family, p.recv_port);
-	const int fd = socket(p.send_family, p.protocol, 0);
+	const int fd = socket(p.send_family, p.protocol, 0), one = 1;
 
 	if (fd < 0)
 		error(1, errno, "failed to create send socket");
 
+	if (setsockopt(fd, SOL_SOCKET, SO_REUSEADDR, &one, sizeof(one)))
+		error(1, errno, "failed to set reuseaddr");
+
 	if (bind(fd, saddr, sockaddr_size()))
 		error(1, errno, "failed to bind send socket");
 
@@ -433,6 +437,21 @@ void enable_fastopen(void)
 	}
 }
 
+static struct rlimit rlim_old, rlim_new;
+
+static  __attribute__((constructor)) void main_ctor(void)
+{
+	getrlimit(RLIMIT_MEMLOCK, &rlim_old);
+	rlim_new.rlim_cur = rlim_old.rlim_cur + (1UL << 20);
+	rlim_new.rlim_max = rlim_old.rlim_max + (1UL << 20);
+	setrlimit(RLIMIT_MEMLOCK, &rlim_new);
+}
+
+static __attribute__((destructor)) void main_dtor(void)
+{
+	setrlimit(RLIMIT_MEMLOCK, &rlim_old);
+}
+
 int main(void)
 {
 	fprintf(stderr, "---- IPv4 UDP ----\n");
