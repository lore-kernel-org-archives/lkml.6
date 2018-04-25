Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+8kQbmC5yFfTC52AOp3dU2B6SmMmSMg9Y1GWVQ+S/H3XEij2h1XCyYAAJC9LOrwaPr2WhM
ARC-Seal: i=1; a=rsa-sha256; t=1524652808; cv=none;
        d=google.com; s=arc-20160816;
        b=qkJ3gE0z4R3HEFQPBrMHJv0grKGwxJ7gPa44DqvzgLJA67lSSGBYDtzO2AteptV5Go
         22Kz+NRIyF+7DdysPNwAar2RiBAuw/oiAtzbcyjzx7IfkG/veMRNJcUqEZ/Q+TD5hY32
         eaiFRxZqo9xaDoXtfgf8aj4U+qU3szbliioGVtDHbusJozbMsj2DKC+qYkbmoUzWpXvy
         o2l+9hoZdApxTVasvOFBZ7zWG8KM7+ISWcrcLUWgASVC9CL9m8DLVAkfpQFqZ6geZmyV
         DKkJV+tgd4nDu1CsSsuU++rF/s3fhSP/H8oVrNLJI0CIu9X17xBKS9CspZLywnzj5av5
         39Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=RVgSsAr1uKAQ665ADRBnPJu5QPJWQsHRBHrhV9z5GaI=;
        b=ph6kT5pdY/Bv0d10cr/1Qq6map68w4KoUmAIRc12o87DhkdF0sSyZfCaL2MGR9g96A
         NJAR8Y27WMmt5TELfBAuvk2HaJs5ChiwozeUh2sHvMuRVvZLBUxoW00J5+TVL4z6L1IR
         1U1UpQNu4lalGtIV37G6+vK0S6H84vL1D3ELgH/35CRPQT6qFjnRjMX3DVPq9FpTDpR7
         y5IvAkO8IW7tbg7RaS+Ae3Qrnm5F7E/c6/oHzKNZr/E0LWQX8nErgo4GdvCC3+BBPBPw
         SIW72fjJjA9sEUAthCk771Z0xPozro8V6tj4ct3NlFWJjjL0oH3xhMBZms7GBOgnR1qz
         ImZQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Prashant Bhole <bhole_prashant_q7@lab.ntt.co.jp>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 077/183] bpf: test_maps: cleanup sockmaps when test ends
Date: Wed, 25 Apr 2018 12:34:57 +0200
Message-Id: <20180425103245.604046986@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180425103242.532713678@linuxfoundation.org>
References: <20180425103242.532713678@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598714343506376450?=
X-GMAIL-MSGID: =?utf-8?q?1598714343506376450?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Prashant Bhole <bhole_prashant_q7@lab.ntt.co.jp>


[ Upstream commit 783687810e986a15ffbf86c516a1a48ff37f38f7 ]

Bug: BPF programs and maps related to sockmaps test exist
in memory even after test_maps ends.

This patch fixes it as a short term workaround (sockmap
kernel side needs real fixing) by empyting sockmaps when
test ends.

Fixes: 6f6d33f3b3d0f ("bpf: selftests add sockmap tests")
Signed-off-by: Prashant Bhole <bhole_prashant_q7@lab.ntt.co.jp>
[ daniel: Note on workaround. ]
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/testing/selftests/bpf/test_maps.c |   16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

--- a/tools/testing/selftests/bpf/test_maps.c
+++ b/tools/testing/selftests/bpf/test_maps.c
@@ -463,7 +463,7 @@ static void test_devmap(int task, void *
 #define SOCKMAP_VERDICT_PROG "./sockmap_verdict_prog.o"
 static void test_sockmap(int tasks, void *data)
 {
-	int one = 1, map_fd_rx, map_fd_tx, map_fd_break, s, sc, rc;
+	int one = 1, map_fd_rx = 0, map_fd_tx = 0, map_fd_break, s, sc, rc;
 	struct bpf_map *bpf_map_rx, *bpf_map_tx, *bpf_map_break;
 	int ports[] = {50200, 50201, 50202, 50204};
 	int err, i, fd, udp, sfd[6] = {0xdeadbeef};
@@ -868,9 +868,12 @@ static void test_sockmap(int tasks, void
 		goto out_sockmap;
 	}
 
-	/* Test map close sockets */
-	for (i = 0; i < 6; i++)
+	/* Test map close sockets and empty maps */
+	for (i = 0; i < 6; i++) {
+		bpf_map_delete_elem(map_fd_tx, &i);
+		bpf_map_delete_elem(map_fd_rx, &i);
 		close(sfd[i]);
+	}
 	close(fd);
 	close(map_fd_rx);
 	bpf_object__close(obj);
@@ -881,8 +884,13 @@ out:
 	printf("Failed to create sockmap '%i:%s'!\n", i, strerror(errno));
 	exit(1);
 out_sockmap:
-	for (i = 0; i < 6; i++)
+	for (i = 0; i < 6; i++) {
+		if (map_fd_tx)
+			bpf_map_delete_elem(map_fd_tx, &i);
+		if (map_fd_rx)
+			bpf_map_delete_elem(map_fd_rx, &i);
 		close(sfd[i]);
+	}
 	close(fd);
 	exit(1);
 }
