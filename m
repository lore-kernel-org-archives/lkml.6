Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+5Jn04bNwXpLsiI887GOR/RalcdIvNNPNFjWAArsKaVZHJ0zq538WWGwrnfu5ejMPwC3WF
ARC-Seal: i=1; a=rsa-sha256; t=1524406724; cv=none;
        d=google.com; s=arc-20160816;
        b=m091PI/r+h7ph98shTBSPjeM+JTI+2Z3CKtqV3WJkWj6wT3ynHo/700MI0VkUPRvLX
         okpzmpJYy34a8Ibvmid6sQAT04MAjucwu88ij4KXztDInxTmWg3O8O8qDhEU306Usqx9
         AKOgs2E9Oi0gCrcwhydqXHlzajTayXRugTXV+TyjgNodTby2rttCouFA1u9Eolv8fdQ7
         I3bunzuklsn/d9hgkkUqk6YNshU2ga6IgftE+BrVbuZgUZLvBZDGhMttG3qiuqmq2Is8
         B/s12ghTCHxxNao+apaZyTRDY5fG4rK96Xo5nuYo/DAzAR/NiFO0sKF8elAiU5v2QPnm
         h+hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=kvxKr8ClEQgx20UWqYp9E/gpYHW1bkkG/5DdzZuDcfU=;
        b=x6sUGSpRaqtQCWYk+eI3jHgZiEOvUqiE7eTlsqxNc40Eb6SnW5iKWACaXf2uVedMV/
         pErG+ROuYpKKhTUOnWc815A6d3RMYL3wESDuk0R2+yGwDoW92UL5GJ6XO4quoL2nKgV9
         +N4JkPNTubjXIVjyaR9D3jzdAMMb8lYe6TX+I5d4gW00tyuAxsdbNipyeXXZWYZEhh3I
         49tLLUGG0bhdh0e9mUE/hSsjySxYKqaBL7yxZfUckGExg104Fi6rjFpLsTW6p3QBaFmD
         g4ftyh4x21X3TqOmnI+D8mrjukfYquPH2hPbMWMfMckQJ4/aHjGQZqcfkxoHbnpHqHxO
         zFnQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Rodrigo Rivas Costa <rodrigorivascosta@gmail.com>,
	Jiri Kosina <jkosina@suse.cz>
Subject: [PATCH 4.4 81/97] HID: hidraw: Fix crash on HIDIOCGFEATURE with a destroyed device
Date: Sun, 22 Apr 2018 15:53:59 +0200
Message-Id: <20180422135309.635020694@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135304.577223025@linuxfoundation.org>
References: <20180422135304.577223025@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455251173047528?=
X-GMAIL-MSGID: =?utf-8?q?1598456305210329990?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Rodrigo Rivas Costa <rodrigorivascosta@gmail.com>

commit a955358d54695e4ad9f7d6489a7ac4d69a8fc711 upstream.

Doing `ioctl(HIDIOCGFEATURE)` in a tight loop on a hidraw device
and then disconnecting the device, or unloading the driver, can
cause a NULL pointer dereference.

When a hidraw device is destroyed it sets 0 to `dev->exist`.
Most functions check 'dev->exist' before doing its work, but
`hidraw_get_report()` was missing that check.

Cc: stable@vger.kernel.org
Signed-off-by: Rodrigo Rivas Costa <rodrigorivascosta@gmail.com>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/hid/hidraw.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/drivers/hid/hidraw.c
+++ b/drivers/hid/hidraw.c
@@ -197,6 +197,11 @@ static ssize_t hidraw_get_report(struct
 	int ret = 0, len;
 	unsigned char report_number;
 
+	if (!hidraw_table[minor] || !hidraw_table[minor]->exist) {
+		ret = -ENODEV;
+		goto out;
+	}
+
 	dev = hidraw_table[minor]->hid;
 
 	if (!dev->ll_driver->raw_request) {
