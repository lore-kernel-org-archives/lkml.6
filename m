Return-Path: <SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZoBhNeWPdRF2F/Q2Li1/psBxSvKmBs2zdjOMiM+N8jI4Ow4Z0qD9CNgUdXLKaIw4H7AUz2n
ARC-Seal: i=1; a=rsa-sha256; t=1526280725; cv=none;
        d=google.com; s=arc-20160816;
        b=eeABAHC2YzzOR1uoUnZHx61suKeA0u3GQ70+JNgPx9dk0dZwPDIuSJ/J6n6/5CmB1N
         RXl0oIFnUpIKLLIbe/WSE5MrOBmOGGEU75CoHRG9H3Jqnd4huPKI2JF4ir3WhLKHnblc
         ybHc+JATMcxiRljguvZUbO6bj2Egy/QyKWQI06o8sBb49Y2BrSf4o6fE2IhjHwk5s1HY
         bCDUvT7Plo8Oj90UFTYWh9AsAz3TDy+Fn9AN1nIHw9t/I3CinML+9LijU2VjUDi00esP
         cyz91dyHOy9hZcOzFk0ZLg3dJzm75T+SepqNT/iPGwcLyoRAFMKA2zR/dM9IDPtObc1z
         1hDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=yGVtmGeITtZGYBU53grf+pNBuqj+sZGg6Vzzg0u+Ky8=;
        b=UWyOFj6O8IYbyOLGBTKSgTkLIxg5Hq2v/5WhcNdAbHOttTLhojzbGmvCfvy6nPt1kF
         j/froLQge7m5TWF6WFi6JH46d1HkFbzaP0OxfoyUmqQLSbHgocvqw4iznWX96NX5dR2l
         H83bu09iPDTu/mju4H2R6PxIjFq2LJny+GZnyMBmdJ1uf9dx1Q7W2qRJzK1ra0evwV1u
         wTBHSFkcArJ/2QPEc/yWHlElxWWssayYWNxkE+XKhFT4VJLYCzQU9HxvYXmKvZQO4SGu
         4hzPtW3hzBy+liDF2/qpuc5eecICtkzpgtNac+sctyJprZh82kRIyVBQw2MtMDGB/oOd
         7EWA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=kU3Zi9V3;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=kU3Zi9V3;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Vasanthakumar Thiagarajan <vthiagar@qti.qualcomm.com>,
	Kalle Valo <kvalo@qca.qualcomm.com>,
	Sriram R <srirrama@codeaurora.org>
Subject: [PATCH 4.4 08/56] ath10k: fix rfc1042 header retrieval in QCA4019 with eth decap mode
Date: Mon, 14 May 2018 08:48:13 +0200
Message-Id: <20180514064755.718467503@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180514064754.853201981@linuxfoundation.org>
References: <20180514064754.853201981@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600421338205908005?=
X-GMAIL-MSGID: =?utf-8?q?1600421338205908005?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vasanthakumar Thiagarajan <vthiagar@qti.qualcomm.com>

commit 2f38c3c01de945234d23dd163e3528ccb413066d upstream.

Chipset from QCA99X0 onwards (QCA99X0, QCA9984, QCA4019 & future)
rx_hdr_status is not padded to align in 4-byte boundary. Define a
new hw_params field to handle different alignment behaviour between
different hw. This patch fixes improper retrieval of rfc1042 header
with QCA4019. This patch along with "ath10k: Properly remove padding
from the start of rx payload" will fix traffic failure in ethernet
decap mode for QCA4019.

Signed-off-by: Vasanthakumar Thiagarajan <vthiagar@qti.qualcomm.com>
Signed-off-by: Kalle Valo <kvalo@qca.qualcomm.com>
Signed-off-by: Sriram R <srirrama@codeaurora.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/wireless/ath/ath10k/core.c |    8 ++++++++
 drivers/net/wireless/ath/ath10k/core.h |    4 ++++
 2 files changed, 12 insertions(+)

--- a/drivers/net/wireless/ath/ath10k/core.c
+++ b/drivers/net/wireless/ath/ath10k/core.c
@@ -67,6 +67,7 @@ static const struct ath10k_hw_params ath
 			.board_size = QCA988X_BOARD_DATA_SZ,
 			.board_ext_size = QCA988X_BOARD_EXT_DATA_SZ,
 		},
+		.decap_align_bytes = 4,
 	},
 	{
 		.id = QCA6174_HW_2_1_VERSION,
@@ -85,6 +86,7 @@ static const struct ath10k_hw_params ath
 			.board_size = QCA6174_BOARD_DATA_SZ,
 			.board_ext_size = QCA6174_BOARD_EXT_DATA_SZ,
 		},
+		.decap_align_bytes = 4,
 	},
 	{
 		.id = QCA6174_HW_2_1_VERSION,
@@ -103,6 +105,7 @@ static const struct ath10k_hw_params ath
 			.board_size = QCA6174_BOARD_DATA_SZ,
 			.board_ext_size = QCA6174_BOARD_EXT_DATA_SZ,
 		},
+		.decap_align_bytes = 4,
 	},
 	{
 		.id = QCA6174_HW_3_0_VERSION,
@@ -121,6 +124,7 @@ static const struct ath10k_hw_params ath
 			.board_size = QCA6174_BOARD_DATA_SZ,
 			.board_ext_size = QCA6174_BOARD_EXT_DATA_SZ,
 		},
+		.decap_align_bytes = 4,
 	},
 	{
 		.id = QCA6174_HW_3_2_VERSION,
@@ -140,6 +144,7 @@ static const struct ath10k_hw_params ath
 			.board_size = QCA6174_BOARD_DATA_SZ,
 			.board_ext_size = QCA6174_BOARD_EXT_DATA_SZ,
 		},
+		.decap_align_bytes = 4,
 	},
 	{
 		.id = QCA99X0_HW_2_0_DEV_VERSION,
@@ -159,6 +164,7 @@ static const struct ath10k_hw_params ath
 			.board_size = QCA99X0_BOARD_DATA_SZ,
 			.board_ext_size = QCA99X0_BOARD_EXT_DATA_SZ,
 		},
+		.decap_align_bytes = 1,
 	},
 	{
 		.id = QCA9377_HW_1_0_DEV_VERSION,
@@ -177,6 +183,7 @@ static const struct ath10k_hw_params ath
 			.board_size = QCA9377_BOARD_DATA_SZ,
 			.board_ext_size = QCA9377_BOARD_EXT_DATA_SZ,
 		},
+		.decap_align_bytes = 4,
 	},
 	{
 		.id = QCA9377_HW_1_1_DEV_VERSION,
@@ -195,6 +202,7 @@ static const struct ath10k_hw_params ath
 			.board_size = QCA9377_BOARD_DATA_SZ,
 			.board_ext_size = QCA9377_BOARD_EXT_DATA_SZ,
 		},
+		.decap_align_bytes = 4,
 	},
 };
 
--- a/drivers/net/wireless/ath/ath10k/core.h
+++ b/drivers/net/wireless/ath/ath10k/core.h
@@ -670,6 +670,10 @@ struct ath10k {
 			size_t board_size;
 			size_t board_ext_size;
 		} fw;
+
+		/* Number of bytes used for alignment in rx_hdr_status */
+		int decap_align_bytes;
+
 	} hw_params;
 
 	const struct firmware *board;
