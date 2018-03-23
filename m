Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELul0SuLH23/VJV2BLC/k8U1qO4LSvXhYCKw3KyQ2uosY5EnmBWZvuppmlgFgZRkCeJnG7oG
ARC-Seal: i=1; a=rsa-sha256; t=1521800217; cv=none;
        d=google.com; s=arc-20160816;
        b=hIbc4DId2LXohjk/v/ES5eMyCz8b3rvRuk41xSai+aGiE/W05rFyI3deCFpY23cl2h
         xnkj1Q1vGDPzNHnKTxY8Fuc9wFP9r3tBOPv7JS8IyCebatMALQata5Sin+VXJwF1/d0M
         cc7V6agQKhibJ4H5mR2T5KwuDyQqQOzi49znj6gICgtmC6/TJg9DicrrunFxinkuFtiB
         n/EJveLHZmrPUd3avlmuuy/Lvtbf9h3WReI+wDRcSbsC7bhflVk7uDYWUhc+H361XvPs
         0k01F6xpjT3zslk1JPTwT7Rgr/msGACKO1AQfeaJtHkbN65M/H2AmDdYJfvJ/KUrdEmB
         o4pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=7jPauSu3WYVxZ8KBHd+dO2tRtMeqgmTLR8hwuG1SVMY=;
        b=xKbg8XLrGypxUhQxRY/l52CMtLTwVX1JAs68nokGoNCmgG4n88kz1qFN3e0PTKo7oF
         VI0fqj0gFOfq2v+lxNrMD5dVQEG/k/yNCsAt58Qi/TcSDYpUw6kCPIr0UnVDIb2egZ39
         bG7nQ0/CtXEw4F609tnxYfzBcP1HIuAMsQEFRO7EmyNRyqKqH1PlyyV0g0s+wg/GF66q
         US4UlqLg1wScyghfATIm/bIHXyaxobgIt1F/aljiKXQ/exxvs4TNnOkqfeSpv8F7KLff
         +/6je2aV9MvSo1vR8uwCTS9CQtrHbagp9l8+kDqxoA5OdcqeYcffZrgmBfI3mcQMDUew
         WnXQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Loic Poulain <loic.poulain@linaro.org>,
	Marcel Holtmann <marcel@holtmann.org>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 73/97] Bluetooth: hci_qca: Avoid setup failure on missing rampatch
Date: Fri, 23 Mar 2018 10:55:00 +0100
Message-Id: <20180323094201.680091918@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323094157.535925724@linuxfoundation.org>
References: <20180323094157.535925724@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595721890038087889?=
X-GMAIL-MSGID: =?utf-8?q?1595723184395217161?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Loic Poulain <loic.poulain@linaro.org>


[ Upstream commit ba8f3597900291a93604643017fff66a14546015 ]

Assuming that the original code idea was to enable in-band sleeping
only if the setup_rome method returns succes and run in 'standard'
mode otherwise, we should not return setup_rome return value which
makes qca_setup fail if no rampatch/nvm file found.

This fixes BT issue on the dragonboard-820C p4 which includes the
following QCA controller:
hci0: Product:0x00000008
hci0: Patch  :0x00000111
hci0: ROM    :0x00000302
hci0: SOC    :0x00000044

Since there is no rampatch for this controller revision, just make
it work as is.

Signed-off-by: Loic Poulain <loic.poulain@linaro.org>
Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/bluetooth/hci_qca.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -936,6 +936,9 @@ static int qca_setup(struct hci_uart *hu
 	if (!ret) {
 		set_bit(STATE_IN_BAND_SLEEP_ENABLED, &qca->flags);
 		qca_debugfs_init(hdev);
+	} else if (ret == -ENOENT) {
+		/* No patch/nvm-config found, run with original fw/config */
+		ret = 0;
 	}
 
 	/* Setup bdaddr */
