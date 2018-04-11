Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48+OHUAxFUWIvzh/jh545q2sES/9WzrSuohQIY0Qu6Ej4OrHMT/dMlQUuQFZeT2pAd014KU
ARC-Seal: i=1; a=rsa-sha256; t=1523471995; cv=none;
        d=google.com; s=arc-20160816;
        b=toWKGuXuhUfjaEoeGUCM+2qjE8qJEX+1VrJbhxmjnbRxZ3SEzui8BvIqvL9hQapj0X
         z0dtw5ASUl8lRPfj/j3hdEEJlbWMfs9BYFXt6EjAPgm1v/4xLTE13a2VbUJ9+pgHXIem
         Kx3pzJ1H1NrZBBd3pX0w1fsCGCKP4FZlrqMn4PmGZkXyOuxqFO3Qqzhk6klQEOIsznAK
         Vy7M9T8EQFyH1EI/uBT03Mw1sxxqG/AmTjXYi6PuvFCa7KdG09sLYlkRnB4VVDdfNTPK
         QQsHO+Jaq/aBOiTGFtTrorEl47qlP5w1QR7caZu0oulEvyAvuFTmfs/+mfsaCl1Mjr0T
         3aZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=2oB4jU2eIJXZxHfGYqsrcCDiEdCsgoQGdBZuESJtjt4=;
        b=NKg1TuXDi979bzgCL2QPRer6JyK9vUSqD9BbJiMqPakbyWCk9DIGWvAS8Sc3yHrNem
         +32kOVAZHhFEI7D6P4MBt1XgSIccMglfutXN2CR9PS4FhOb2qFuqxk1FQvIXf6Te5+Dt
         BQOwGzMdunOPwvHLZZaqRqU34trtjFI3cjCRl7etk862njR7V3W3qmh6uhLUwqI1y6VX
         SAwywf7OBtvHPRzC2mszuYkt7uTisr5hiOSGnnvzVptGA+P/lKUABWRFdXmRoGKW7MaR
         XxacaoMYuMrE8p912tJDbKZ85N0ugH+baYhLChD16prLE747lq8fSY06Y+gFhvE9j55j
         qm8w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Neil Horman <nhorman@tuxdriver.com>,
	Shrikrishna Khare <skhare@vmware.com>,
	"VMware, Inc." <pv-drivers@vmware.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 016/121] vmxnet3: ensure that adapter is in proper state during force_close
Date: Wed, 11 Apr 2018 20:35:19 +0200
Message-Id: <20180411183457.148275052@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183456.195010921@linuxfoundation.org>
References: <20180411183456.195010921@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597476171103910380?=
X-GMAIL-MSGID: =?utf-8?q?1597476171103910380?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Neil Horman <nhorman@tuxdriver.com>


[ Upstream commit 1c4d5f51a812a82de97beee24f48ed05c65ebda5 ]

There are several paths in vmxnet3, where settings changes cause the
adapter to be brought down and back up (vmxnet3_set_ringparam among
them).  Should part of the reset operation fail, these paths call
vmxnet3_force_close, which enables all napi instances prior to calling
dev_close (with the expectation that vmxnet3_close will then properly
disable them again).  However, vmxnet3_force_close neglects to clear
VMXNET3_STATE_BIT_QUIESCED prior to calling dev_close.  As a result
vmxnet3_quiesce_dev (called from vmxnet3_close), returns early, and
leaves all the napi instances in a enabled state while the device itself
is closed.  If a device in this state is activated again, napi_enable
will be called on already enabled napi_instances, leading to a BUG halt.

The fix is to simply enausre that the QUIESCED bit is cleared in
vmxnet3_force_close to allow quesence to be completed properly on close.

Signed-off-by: Neil Horman <nhorman@tuxdriver.com>
CC: Shrikrishna Khare <skhare@vmware.com>
CC: "VMware, Inc." <pv-drivers@vmware.com>
CC: "David S. Miller" <davem@davemloft.net>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/vmxnet3/vmxnet3_drv.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/drivers/net/vmxnet3/vmxnet3_drv.c
+++ b/drivers/net/vmxnet3/vmxnet3_drv.c
@@ -2648,6 +2648,11 @@ vmxnet3_force_close(struct vmxnet3_adapt
 	/* we need to enable NAPI, otherwise dev_close will deadlock */
 	for (i = 0; i < adapter->num_rx_queues; i++)
 		napi_enable(&adapter->rx_queue[i].napi);
+	/*
+	 * Need to clear the quiesce bit to ensure that vmxnet3_close
+	 * can quiesce the device properly
+	 */
+	clear_bit(VMXNET3_STATE_BIT_QUIESCED, &adapter->state);
 	dev_close(adapter->netdev);
 }
 
