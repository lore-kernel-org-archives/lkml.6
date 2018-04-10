Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+fLY4a6o6VqRpJieW9x+zaPBCIVZnyu4HOhRbIr94k8LtqKm3mUNfAjonMeJSc8f67WBwl
ARC-Seal: i=1; a=rsa-sha256; t=1523399588; cv=none;
        d=google.com; s=arc-20160816;
        b=SEJKMZjAIrtQpEWeOL0XXzrhG62zIoHNOi6T6OA73+XWLCmFoFLoC9uf0ehqFzSesu
         1RRWkFz4LN1XdbBTy4T5vPHx02+lBBRfDcejI0fJkOd4qEyWajW17JuNOFxg6fjoOFaN
         OtFSCrFNv1fu7KitIp4I+6iEN/oKl8p/oFrk2HFoL2j2IbI+KEGYSL9CeNYm4Zf5uzH9
         Le6SCJmQS3YhQWCk9mi7P5kkO3AlGmtNDj5kDj1BASMqDrLsfOTstBtdBgir84JiRfnt
         zxKhdRT/WkUejMUoL56aUbOkJWWxrS9ONEx1V+OQPc834KSDh1BDAp2URHv7SDgdftrj
         rCTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=IUrBv36s8zWoiM6yaTR03OMANKF74uCn5cvI7a5X8iM=;
        b=SPYbvJwFw+3eNuFPRhdL93qCHccST+Ep515MrFChqHZEjTVHS9+MVte2PSzE3VynCA
         d2nNXajIqK9rj0aKfPziMXozqAKYJVxnvRy+3KJeePPmAL1EFe6Nn/pJM37izjNHsuOc
         8gkTWZN4QSslDJcvJQP3aw26i3DazRZuY4FFJk+vvD4kTZgIyT0EhoZIcwfPF+t7BmEd
         qGTjb1DPs3pzBNpCvIamcxcurb9B6I5vF5eMxsfCqtim5letpgkSkUtPVr+A74wbYEJ7
         fbnjGNG4O/BHT+lsJdglFpmAFpzwsz3hbwONk3lNNcsqNXSycm82TWctUNxKbcpKYQ82
         zKZg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Dirk van der Merwe <dirk.vandermerwe@netronome.com>,
	Jakub Kicinski <jakub.kicinski@netronome.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.15 155/168] nfp: use full 40 bits of the NSP buffer address
Date: Wed, 11 Apr 2018 00:24:57 +0200
Message-Id: <20180410212807.683545279@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410212800.144079021@linuxfoundation.org>
References: <20180410212800.144079021@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597399732880753270?=
X-GMAIL-MSGID: =?utf-8?q?1597400246905306182?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dirk van der Merwe <dirk.vandermerwe@netronome.com>


[ Upstream commit 1489bbd10e16079ce30a53d3c22a431fd47af791 ]

The NSP default buffer is a piece of NFP memory where additional
command data can be placed.  Its format has been copied from
host buffer, but the PCIe selection bits do not make sense in
this case.  If those get masked out from a NFP address - writes
to random place in the chip memory may be issued and crash the
device.

Even in the general NSP buffer case, it doesn't make sense to have the
PCIe selection bits there anymore. These are unused at the moment, and
when it becomes necessary, the PCIe selection bits should rather be
moved to another register to utilise more bits for the buffer address.

This has never been an issue because the buffer used to be
allocated in memory with less-than-38-bit-long address but that
is about to change.

Fixes: 1a64821c6af7 ("nfp: add support for service processor access")
Signed-off-by: Dirk van der Merwe <dirk.vandermerwe@netronome.com>
Reviewed-by: Jakub Kicinski <jakub.kicinski@netronome.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/netronome/nfp/nfpcore/nfp_nsp.c |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

--- a/drivers/net/ethernet/netronome/nfp/nfpcore/nfp_nsp.c
+++ b/drivers/net/ethernet/netronome/nfp/nfpcore/nfp_nsp.c
@@ -68,10 +68,11 @@
 /* CPP address to retrieve the data from */
 #define NSP_BUFFER		0x10
 #define   NSP_BUFFER_CPP	GENMASK_ULL(63, 40)
-#define   NSP_BUFFER_PCIE	GENMASK_ULL(39, 38)
-#define   NSP_BUFFER_ADDRESS	GENMASK_ULL(37, 0)
+#define   NSP_BUFFER_ADDRESS	GENMASK_ULL(39, 0)
 
 #define NSP_DFLT_BUFFER		0x18
+#define   NSP_DFLT_BUFFER_CPP	GENMASK_ULL(63, 40)
+#define   NSP_DFLT_BUFFER_ADDRESS	GENMASK_ULL(39, 0)
 
 #define NSP_DFLT_BUFFER_CONFIG	0x20
 #define   NSP_DFLT_BUFFER_SIZE_MB	GENMASK_ULL(7, 0)
@@ -412,8 +413,8 @@ static int nfp_nsp_command_buf(struct nf
 	if (err < 0)
 		return err;
 
-	cpp_id = FIELD_GET(NSP_BUFFER_CPP, reg) << 8;
-	cpp_buf = FIELD_GET(NSP_BUFFER_ADDRESS, reg);
+	cpp_id = FIELD_GET(NSP_DFLT_BUFFER_CPP, reg) << 8;
+	cpp_buf = FIELD_GET(NSP_DFLT_BUFFER_ADDRESS, reg);
 
 	if (in_buf && in_size) {
 		err = nfp_cpp_write(cpp, cpp_id, cpp_buf, in_buf, in_size);
