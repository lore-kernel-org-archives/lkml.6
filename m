Return-Path: <SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZpJNx/zpASJr7volqIFCdfZoCQHoMZsauPVgStQh6jD9A2iPI5LKSKurYjovgplhERU5pLr
ARC-Seal: i=1; a=rsa-sha256; t=1526631638; cv=none;
        d=google.com; s=arc-20160816;
        b=IjADeJ1zBuX7qhgNlzYaR44/Ff2yl5r960Le9S1hpJh2rPSaWzokohE1UsBAcMZM/o
         rd3/N2A6l2Mp5LE9TNMrh9e0Que1l4sW2p5ZR7KS7pgGa2x7Gz951qLKixIs12Sg1b6V
         v1VBVsXOxCaX4F4qMkLJrIDENTRL80y310PxFf7l7hS9KB/JGYRzO7uErSG3349w6gq6
         +FaEi3VT5e8SRCrootMx7wpzilIVO8e8n48qFfkEV3OnrW+V6ttnMhuv1Ge0wCrwIL2h
         zRe1C2PeJ5PHUmBdAg+LyOQuV9jO5m+OEFMfUNvGS8tWKvWV1Dc+Yz7XCernXCd9Se6n
         xLyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=g6teRLiML09fTIFl+52OxrEN/hxcaei4JXnurEEPBKE=;
        b=RsfkV9TKJu3LERyk3onzCE7RSoJ8g2RZWEy2kfbOnBEz6pEexgP5nOXBfNPdoZcbWx
         JW41Zn6zV4wJpF2CJxSkYfn0dJLoQIjNgyVXJuIwyaC/lY4T2pHkqBsrEyb8AvELrl4h
         1z8ig+Fn2rLi7I68oGyiTS9HogQh1SVVb5K0sjJtp0ISP1Sb0W3fMM+QGahccgfTxJhU
         uypV4pu0smgUagthi1K/IMXZ1sbJ1QtHkoGRVloRAb5mEgAlX2ap09dv1F9TXGQaqQMc
         NfnrWfVe3EWTQL4VaHAN2az5m380h08MPWwG7kRSfVtXFJ32g/Y0afoOPJoN9lcIbLS/
         53Xg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=Xl3ioQcx;
       spf=pass (google.com: domain of srs0=xuy6=if=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=Xl3ioQcx;
       spf=pass (google.com: domain of srs0=xuy6=if=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>,
	Jiri Benc <jbenc@redhat.com>,
	syzbot <syzkaller@googlegroups.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 38/45] nsh: fix infinite loop
Date: Fri, 18 May 2018 10:15:55 +0200
Message-Id: <20180518081532.309130329@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180518081530.331586165@linuxfoundation.org>
References: <20180518081530.331586165@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600789142317733610?=
X-GMAIL-MSGID: =?utf-8?q?1600789297535574250?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit af50e4ba34f4c45e92535364133d4deb5931c1c5 ]

syzbot caught an infinite recursion in nsh_gso_segment().

Problem here is that we need to make sure the NSH header is of
reasonable length.

BUG: MAX_LOCK_DEPTH too low!
turning off the locking correctness validator.
depth: 48  max: 48!
48 locks held by syz-executor0/10189:
 #0:         (ptrval) (rcu_read_lock_bh){....}, at: __dev_queue_xmit+0x30f/0x34c0 net/core/dev.c:3517
 #1:         (ptrval) (rcu_read_lock){....}, at: __skb_pull include/linux/skbuff.h:2080 [inline]
 #1:         (ptrval) (rcu_read_lock){....}, at: skb_mac_gso_segment+0x221/0x720 net/core/dev.c:2787
 #2:         (ptrval) (rcu_read_lock){....}, at: __skb_pull include/linux/skbuff.h:2080 [inline]
 #2:         (ptrval) (rcu_read_lock){....}, at: skb_mac_gso_segment+0x221/0x720 net/core/dev.c:2787
 #3:         (ptrval) (rcu_read_lock){....}, at: __skb_pull include/linux/skbuff.h:2080 [inline]
 #3:         (ptrval) (rcu_read_lock){....}, at: skb_mac_gso_segment+0x221/0x720 net/core/dev.c:2787
 #4:         (ptrval) (rcu_read_lock){....}, at: __skb_pull include/linux/skbuff.h:2080 [inline]
 #4:         (ptrval) (rcu_read_lock){....}, at: skb_mac_gso_segment+0x221/0x720 net/core/dev.c:2787
 #5:         (ptrval) (rcu_read_lock){....}, at: __skb_pull include/linux/skbuff.h:2080 [inline]
 #5:         (ptrval) (rcu_read_lock){....}, at: skb_mac_gso_segment+0x221/0x720 net/core/dev.c:2787
 #6:         (ptrval) (rcu_read_lock){....}, at: __skb_pull include/linux/skbuff.h:2080 [inline]
 #6:         (ptrval) (rcu_read_lock){....}, at: skb_mac_gso_segment+0x221/0x720 net/core/dev.c:2787
 #7:         (ptrval) (rcu_read_lock){....}, at: __skb_pull include/linux/skbuff.h:2080 [inline]
 #7:         (ptrval) (rcu_read_lock){....}, at: skb_mac_gso_segment+0x221/0x720 net/core/dev.c:2787
 #8:         (ptrval) (rcu_read_lock){....}, at: __skb_pull include/linux/skbuff.h:2080 [inline]
 #8:         (ptrval) (rcu_read_lock){....}, at: skb_mac_gso_segment+0x221/0x720 net/core/dev.c:2787
 #9:         (ptrval) (rcu_read_lock){....}, at: __skb_pull include/linux/skbuff.h:2080 [inline]
 #9:         (ptrval) (rcu_read_lock){....}, at: skb_mac_gso_segment+0x221/0x720 net/core/dev.c:2787
 #10:         (ptrval) (rcu_read_lock){....}, at: __skb_pull include/linux/skbuff.h:2080 [inline]
 #10:         (ptrval) (rcu_read_lock){....}, at: skb_mac_gso_segment+0x221/0x720 net/core/dev.c:2787
 #11:         (ptrval) (rcu_read_lock){....}, at: __skb_pull include/linux/skbuff.h:2080 [inline]
 #11:         (ptrval) (rcu_read_lock){....}, at: skb_mac_gso_segment+0x221/0x720 net/core/dev.c:2787
 #12:         (ptrval) (rcu_read_lock){....}, at: __skb_pull include/linux/skbuff.h:2080 [inline]
 #12:         (ptrval) (rcu_read_lock){....}, at: skb_mac_gso_segment+0x221/0x720 net/core/dev.c:2787
 #13:         (ptrval) (rcu_read_lock){....}, at: __skb_pull include/linux/skbuff.h:2080 [inline]
 #13:         (ptrval) (rcu_read_lock){....}, at: skb_mac_gso_segment+0x221/0x720 net/core/dev.c:2787
 #14:         (ptrval) (rcu_read_lock){....}, at: __skb_pull include/linux/skbuff.h:2080 [inline]
 #14:         (ptrval) (rcu_read_lock){....}, at: skb_mac_gso_segment+0x221/0x720 net/core/dev.c:2787
 #15:         (ptrval) (rcu_read_lock){....}, at: __skb_pull include/linux/skbuff.h:2080 [inline]
 #15:         (ptrval) (rcu_read_lock){....}, at: skb_mac_gso_segment+0x221/0x720 net/core/dev.c:2787
 #16:         (ptrval) (rcu_read_lock){....}, at: __skb_pull include/linux/skbuff.h:2080 [inline]
 #16:         (ptrval) (rcu_read_lock){....}, at: skb_mac_gso_segment+0x221/0x720 net/core/dev.c:2787
 #17:         (ptrval) (rcu_read_lock){....}, at: __skb_pull include/linux/skbuff.h:2080 [inline]
 #17:         (ptrval) (rcu_read_lock){....}, at: skb_mac_gso_segment+0x221/0x720 net/core/dev.c:2787
 #18:         (ptrval) (rcu_read_lock){....}, at: __skb_pull include/linux/skbuff.h:2080 [inline]
 #18:         (ptrval) (rcu_read_lock){....}, at: skb_mac_gso_segment+0x221/0x720 net/core/dev.c:2787
 #19:         (ptrval) (rcu_read_lock){....}, at: __skb_pull include/linux/skbuff.h:2080 [inline]
 #19:         (ptrval) (rcu_read_lock){....}, at: skb_mac_gso_segment+0x221/0x720 net/core/dev.c:2787
 #20:         (ptrval) (rcu_read_lock){....}, at: __skb_pull include/linux/skbuff.h:2080 [inline]
 #20:         (ptrval) (rcu_read_lock){....}, at: skb_mac_gso_segment+0x221/0x720 net/core/dev.c:2787
 #21:         (ptrval) (rcu_read_lock){....}, at: __skb_pull include/linux/skbuff.h:2080 [inline]
 #21:         (ptrval) (rcu_read_lock){....}, at: skb_mac_gso_segment+0x221/0x720 net/core/dev.c:2787
 #22:         (ptrval) (rcu_read_lock){....}, at: __skb_pull include/linux/skbuff.h:2080 [inline]
 #22:         (ptrval) (rcu_read_lock){....}, at: skb_mac_gso_segment+0x221/0x720 net/core/dev.c:2787
 #23:         (ptrval) (rcu_read_lock){....}, at: __skb_pull include/linux/skbuff.h:2080 [inline]
 #23:         (ptrval) (rcu_read_lock){....}, at: skb_mac_gso_segment+0x221/0x720 net/core/dev.c:2787
 #24:         (ptrval) (rcu_read_lock){....}, at: __skb_pull include/linux/skbuff.h:2080 [inline]
 #24:         (ptrval) (rcu_read_lock){....}, at: skb_mac_gso_segment+0x221/0x720 net/core/dev.c:2787
 #25:         (ptrval) (rcu_read_lock){....}, at: __skb_pull include/linux/skbuff.h:2080 [inline]
 #25:         (ptrval) (rcu_read_lock){....}, at: skb_mac_gso_segment+0x221/0x720 net/core/dev.c:2787
 #26:         (ptrval) (rcu_read_lock){....}, at: __skb_pull include/linux/skbuff.h:2080 [inline]
 #26:         (ptrval) (rcu_read_lock){....}, at: skb_mac_gso_segment+0x221/0x720 net/core/dev.c:2787
 #27:         (ptrval) (rcu_read_lock){....}, at: __skb_pull include/linux/skbuff.h:2080 [inline]
 #27:         (ptrval) (rcu_read_lock){....}, at: skb_mac_gso_segment+0x221/0x720 net/core/dev.c:2787
 #28:         (ptrval) (rcu_read_lock){....}, at: __skb_pull include/linux/skbuff.h:2080 [inline]
 #28:         (ptrval) (rcu_read_lock){....}, at: skb_mac_gso_segment+0x221/0x720 net/core/dev.c:2787
 #29:         (ptrval) (rcu_read_lock){....}, at: __skb_pull include/linux/skbuff.h:2080 [inline]
 #29:         (ptrval) (rcu_read_lock){....}, at: skb_mac_gso_segment+0x221/0x720 net/core/dev.c:2787
 #30:         (ptrval) (rcu_read_lock){....}, at: __skb_pull include/linux/skbuff.h:2080 [inline]
 #30:         (ptrval) (rcu_read_lock){....}, at: skb_mac_gso_segment+0x221/0x720 net/core/dev.c:2787
 #31:         (ptrval) (rcu_read_lock){....}, at: __skb_pull include/linux/skbuff.h:2080 [inline]
 #31:         (ptrval) (rcu_read_lock){....}, at: skb_mac_gso_segment+0x221/0x720 net/core/dev.c:2787
dccp_close: ABORT with 65423 bytes unread
 #32:         (ptrval) (rcu_read_lock){....}, at: __skb_pull include/linux/skbuff.h:2080 [inline]
 #32:         (ptrval) (rcu_read_lock){....}, at: skb_mac_gso_segment+0x221/0x720 net/core/dev.c:2787
 #33:         (ptrval) (rcu_read_lock){....}, at: __skb_pull include/linux/skbuff.h:2080 [inline]
 #33:         (ptrval) (rcu_read_lock){....}, at: skb_mac_gso_segment+0x221/0x720 net/core/dev.c:2787
 #34:         (ptrval) (rcu_read_lock){....}, at: __skb_pull include/linux/skbuff.h:2080 [inline]
 #34:         (ptrval) (rcu_read_lock){....}, at: skb_mac_gso_segment+0x221/0x720 net/core/dev.c:2787
 #35:         (ptrval) (rcu_read_lock){....}, at: __skb_pull include/linux/skbuff.h:2080 [inline]
 #35:         (ptrval) (rcu_read_lock){....}, at: skb_mac_gso_segment+0x221/0x720 net/core/dev.c:2787
 #36:         (ptrval) (rcu_read_lock){....}, at: __skb_pull include/linux/skbuff.h:2080 [inline]
 #36:         (ptrval) (rcu_read_lock){....}, at: skb_mac_gso_segment+0x221/0x720 net/core/dev.c:2787
 #37:         (ptrval) (rcu_read_lock){....}, at: __skb_pull include/linux/skbuff.h:2080 [inline]
 #37:         (ptrval) (rcu_read_lock){....}, at: skb_mac_gso_segment+0x221/0x720 net/core/dev.c:2787
 #38:         (ptrval) (rcu_read_lock){....}, at: __skb_pull include/linux/skbuff.h:2080 [inline]
 #38:         (ptrval) (rcu_read_lock){....}, at: skb_mac_gso_segment+0x221/0x720 net/core/dev.c:2787
 #39:         (ptrval) (rcu_read_lock){....}, at: __skb_pull include/linux/skbuff.h:2080 [inline]
 #39:         (ptrval) (rcu_read_lock){....}, at: skb_mac_gso_segment+0x221/0x720 net/core/dev.c:2787
 #40:         (ptrval) (rcu_read_lock){....}, at: __skb_pull include/linux/skbuff.h:2080 [inline]
 #40:         (ptrval) (rcu_read_lock){....}, at: skb_mac_gso_segment+0x221/0x720 net/core/dev.c:2787
 #41:         (ptrval) (rcu_read_lock){....}, at: __skb_pull include/linux/skbuff.h:2080 [inline]
 #41:         (ptrval) (rcu_read_lock){....}, at: skb_mac_gso_segment+0x221/0x720 net/core/dev.c:2787
 #42:         (ptrval) (rcu_read_lock){....}, at: __skb_pull include/linux/skbuff.h:2080 [inline]
 #42:         (ptrval) (rcu_read_lock){....}, at: skb_mac_gso_segment+0x221/0x720 net/core/dev.c:2787
 #43:         (ptrval) (rcu_read_lock){....}, at: __skb_pull include/linux/skbuff.h:2080 [inline]
 #43:         (ptrval) (rcu_read_lock){....}, at: skb_mac_gso_segment+0x221/0x720 net/core/dev.c:2787
 #44:         (ptrval) (rcu_read_lock){....}, at: __skb_pull include/linux/skbuff.h:2080 [inline]
 #44:         (ptrval) (rcu_read_lock){....}, at: skb_mac_gso_segment+0x221/0x720 net/core/dev.c:2787
 #45:         (ptrval) (rcu_read_lock){....}, at: __skb_pull include/linux/skbuff.h:2080 [inline]
 #45:         (ptrval) (rcu_read_lock){....}, at: skb_mac_gso_segment+0x221/0x720 net/core/dev.c:2787
 #46:         (ptrval) (rcu_read_lock){....}, at: __skb_pull include/linux/skbuff.h:2080 [inline]
 #46:         (ptrval) (rcu_read_lock){....}, at: skb_mac_gso_segment+0x221/0x720 net/core/dev.c:2787
 #47:         (ptrval) (rcu_read_lock){....}, at: __skb_pull include/linux/skbuff.h:2080 [inline]
 #47:         (ptrval) (rcu_read_lock){....}, at: skb_mac_gso_segment+0x221/0x720 net/core/dev.c:2787
INFO: lockdep is turned off.
CPU: 1 PID: 10189 Comm: syz-executor0 Not tainted 4.17.0-rc2+ #26
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x1b9/0x294 lib/dump_stack.c:113
 __lock_acquire+0x1788/0x5140 kernel/locking/lockdep.c:3449
 lock_acquire+0x1dc/0x520 kernel/locking/lockdep.c:3920
 rcu_lock_acquire include/linux/rcupdate.h:246 [inline]
 rcu_read_lock include/linux/rcupdate.h:632 [inline]
 skb_mac_gso_segment+0x25b/0x720 net/core/dev.c:2789
 nsh_gso_segment+0x405/0xb60 net/nsh/nsh.c:107
 skb_mac_gso_segment+0x3ad/0x720 net/core/dev.c:2792
 nsh_gso_segment+0x405/0xb60 net/nsh/nsh.c:107
 skb_mac_gso_segment+0x3ad/0x720 net/core/dev.c:2792
 nsh_gso_segment+0x405/0xb60 net/nsh/nsh.c:107
 skb_mac_gso_segment+0x3ad/0x720 net/core/dev.c:2792
 nsh_gso_segment+0x405/0xb60 net/nsh/nsh.c:107
 skb_mac_gso_segment+0x3ad/0x720 net/core/dev.c:2792
 nsh_gso_segment+0x405/0xb60 net/nsh/nsh.c:107
 skb_mac_gso_segment+0x3ad/0x720 net/core/dev.c:2792
 nsh_gso_segment+0x405/0xb60 net/nsh/nsh.c:107
 skb_mac_gso_segment+0x3ad/0x720 net/core/dev.c:2792
 nsh_gso_segment+0x405/0xb60 net/nsh/nsh.c:107
 skb_mac_gso_segment+0x3ad/0x720 net/core/dev.c:2792
 nsh_gso_segment+0x405/0xb60 net/nsh/nsh.c:107
 skb_mac_gso_segment+0x3ad/0x720 net/core/dev.c:2792
 nsh_gso_segment+0x405/0xb60 net/nsh/nsh.c:107
 skb_mac_gso_segment+0x3ad/0x720 net/core/dev.c:2792
 nsh_gso_segment+0x405/0xb60 net/nsh/nsh.c:107
 skb_mac_gso_segment+0x3ad/0x720 net/core/dev.c:2792
 nsh_gso_segment+0x405/0xb60 net/nsh/nsh.c:107
 skb_mac_gso_segment+0x3ad/0x720 net/core/dev.c:2792
 nsh_gso_segment+0x405/0xb60 net/nsh/nsh.c:107
 skb_mac_gso_segment+0x3ad/0x720 net/core/dev.c:2792
 nsh_gso_segment+0x405/0xb60 net/nsh/nsh.c:107
 skb_mac_gso_segment+0x3ad/0x720 net/core/dev.c:2792
 nsh_gso_segment+0x405/0xb60 net/nsh/nsh.c:107
 skb_mac_gso_segment+0x3ad/0x720 net/core/dev.c:2792
 nsh_gso_segment+0x405/0xb60 net/nsh/nsh.c:107
 skb_mac_gso_segment+0x3ad/0x720 net/core/dev.c:2792
 nsh_gso_segment+0x405/0xb60 net/nsh/nsh.c:107
 skb_mac_gso_segment+0x3ad/0x720 net/core/dev.c:2792
 nsh_gso_segment+0x405/0xb60 net/nsh/nsh.c:107
 skb_mac_gso_segment+0x3ad/0x720 net/core/dev.c:2792
 nsh_gso_segment+0x405/0xb60 net/nsh/nsh.c:107
 skb_mac_gso_segment+0x3ad/0x720 net/core/dev.c:2792
 nsh_gso_segment+0x405/0xb60 net/nsh/nsh.c:107
 skb_mac_gso_segment+0x3ad/0x720 net/core/dev.c:2792
 nsh_gso_segment+0x405/0xb60 net/nsh/nsh.c:107
 skb_mac_gso_segment+0x3ad/0x720 net/core/dev.c:2792
 nsh_gso_segment+0x405/0xb60 net/nsh/nsh.c:107
 skb_mac_gso_segment+0x3ad/0x720 net/core/dev.c:2792
 nsh_gso_segment+0x405/0xb60 net/nsh/nsh.c:107
 skb_mac_gso_segment+0x3ad/0x720 net/core/dev.c:2792
 nsh_gso_segment+0x405/0xb60 net/nsh/nsh.c:107
 skb_mac_gso_segment+0x3ad/0x720 net/core/dev.c:2792
 nsh_gso_segment+0x405/0xb60 net/nsh/nsh.c:107
 skb_mac_gso_segment+0x3ad/0x720 net/core/dev.c:2792
 nsh_gso_segment+0x405/0xb60 net/nsh/nsh.c:107
 skb_mac_gso_segment+0x3ad/0x720 net/core/dev.c:2792
 nsh_gso_segment+0x405/0xb60 net/nsh/nsh.c:107
 skb_mac_gso_segment+0x3ad/0x720 net/core/dev.c:2792
 nsh_gso_segment+0x405/0xb60 net/nsh/nsh.c:107
 skb_mac_gso_segment+0x3ad/0x720 net/core/dev.c:2792
 nsh_gso_segment+0x405/0xb60 net/nsh/nsh.c:107
 skb_mac_gso_segment+0x3ad/0x720 net/core/dev.c:2792
 nsh_gso_segment+0x405/0xb60 net/nsh/nsh.c:107
 skb_mac_gso_segment+0x3ad/0x720 net/core/dev.c:2792
 nsh_gso_segment+0x405/0xb60 net/nsh/nsh.c:107
 skb_mac_gso_segment+0x3ad/0x720 net/core/dev.c:2792
 nsh_gso_segment+0x405/0xb60 net/nsh/nsh.c:107
 skb_mac_gso_segment+0x3ad/0x720 net/core/dev.c:2792
 nsh_gso_segment+0x405/0xb60 net/nsh/nsh.c:107
 skb_mac_gso_segment+0x3ad/0x720 net/core/dev.c:2792
 nsh_gso_segment+0x405/0xb60 net/nsh/nsh.c:107
 skb_mac_gso_segment+0x3ad/0x720 net/core/dev.c:2792
 nsh_gso_segment+0x405/0xb60 net/nsh/nsh.c:107
 skb_mac_gso_segment+0x3ad/0x720 net/core/dev.c:2792
 nsh_gso_segment+0x405/0xb60 net/nsh/nsh.c:107
 skb_mac_gso_segment+0x3ad/0x720 net/core/dev.c:2792
 nsh_gso_segment+0x405/0xb60 net/nsh/nsh.c:107
 skb_mac_gso_segment+0x3ad/0x720 net/core/dev.c:2792
 nsh_gso_segment+0x405/0xb60 net/nsh/nsh.c:107
 skb_mac_gso_segment+0x3ad/0x720 net/core/dev.c:2792
 nsh_gso_segment+0x405/0xb60 net/nsh/nsh.c:107
 skb_mac_gso_segment+0x3ad/0x720 net/core/dev.c:2792
 nsh_gso_segment+0x405/0xb60 net/nsh/nsh.c:107
 skb_mac_gso_segment+0x3ad/0x720 net/core/dev.c:2792
 nsh_gso_segment+0x405/0xb60 net/nsh/nsh.c:107
 skb_mac_gso_segment+0x3ad/0x720 net/core/dev.c:2792
 nsh_gso_segment+0x405/0xb60 net/nsh/nsh.c:107
 skb_mac_gso_segment+0x3ad/0x720 net/core/dev.c:2792
 nsh_gso_segment+0x405/0xb60 net/nsh/nsh.c:107
 skb_mac_gso_segment+0x3ad/0x720 net/core/dev.c:2792
 nsh_gso_segment+0x405/0xb60 net/nsh/nsh.c:107
 skb_mac_gso_segment+0x3ad/0x720 net/core/dev.c:2792
 nsh_gso_segment+0x405/0xb60 net/nsh/nsh.c:107
 skb_mac_gso_segment+0x3ad/0x720 net/core/dev.c:2792
 nsh_gso_segment+0x405/0xb60 net/nsh/nsh.c:107
 skb_mac_gso_segment+0x3ad/0x720 net/core/dev.c:2792
 nsh_gso_segment+0x405/0xb60 net/nsh/nsh.c:107
 skb_mac_gso_segment+0x3ad/0x720 net/core/dev.c:2792
 __skb_gso_segment+0x3bb/0x870 net/core/dev.c:2865
 skb_gso_segment include/linux/netdevice.h:4025 [inline]
 validate_xmit_skb+0x54d/0xd90 net/core/dev.c:3118
 validate_xmit_skb_list+0xbf/0x120 net/core/dev.c:3168
 sch_direct_xmit+0x354/0x11e0 net/sched/sch_generic.c:312
 qdisc_restart net/sched/sch_generic.c:399 [inline]
 __qdisc_run+0x741/0x1af0 net/sched/sch_generic.c:410
 __dev_xmit_skb net/core/dev.c:3243 [inline]
 __dev_queue_xmit+0x28ea/0x34c0 net/core/dev.c:3551
 dev_queue_xmit+0x17/0x20 net/core/dev.c:3616
 packet_snd net/packet/af_packet.c:2951 [inline]
 packet_sendmsg+0x40f8/0x6070 net/packet/af_packet.c:2976
 sock_sendmsg_nosec net/socket.c:629 [inline]
 sock_sendmsg+0xd5/0x120 net/socket.c:639
 __sys_sendto+0x3d7/0x670 net/socket.c:1789
 __do_sys_sendto net/socket.c:1801 [inline]
 __se_sys_sendto net/socket.c:1797 [inline]
 __x64_sys_sendto+0xe1/0x1a0 net/socket.c:1797
 do_syscall_64+0x1b1/0x800 arch/x86/entry/common.c:287
 entry_SYSCALL_64_after_hwframe+0x49/0xbe

Fixes: c411ed854584 ("nsh: add GSO support")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Jiri Benc <jbenc@redhat.com>
Reported-by: syzbot <syzkaller@googlegroups.com>
Acked-by: Jiri Benc <jbenc@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/nsh/nsh.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/net/nsh/nsh.c
+++ b/net/nsh/nsh.c
@@ -30,6 +30,8 @@ static struct sk_buff *nsh_gso_segment(s
 	if (unlikely(!pskb_may_pull(skb, NSH_BASE_HDR_LEN)))
 		goto out;
 	nsh_len = nsh_hdr_len(nsh_hdr(skb));
+	if (nsh_len < NSH_BASE_HDR_LEN)
+		goto out;
 	if (unlikely(!pskb_may_pull(skb, nsh_len)))
 		goto out;
 
