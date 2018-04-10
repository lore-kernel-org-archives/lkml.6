Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48sNSMAc1vI6/oWUjCuAxi8KKihIqPVrIDQcjUWGg7GG/x3Drn0cnPZxhd3sdER5z5uEt4o
ARC-Seal: i=1; a=rsa-sha256; t=1523399098; cv=none;
        d=google.com; s=arc-20160816;
        b=GcnbOUdM4mIu3wTe8y5Z9PHLxHvc4Wzkeuz33dMf5p/HLqpxVdawHvXwqtX5jZ933K
         14r0lva/bIUQw8PXjCaqv+LbDMwFFEogUPnUr25l1IBVkS0hkd8BFDA2hcjC+tS5/5ep
         d6qIKEou5CGzjp9e7SHht34ZCEEiBAo/PS4lbG+e0UMmfgbxHk/+UH3INpetFVtVGd2D
         IQus2MjSP6tPJ4jJu5q5KKctiz/G8JrogPJx+Bv7sUSAheugBjyt/TY7ghMnbfCvOuOh
         qdPX3q6g41MaMBeYErc+y5rxSvQI8bpXRHzUbKGWGKRi+S2W4cGTwILIZdIV2VfscgCa
         QECg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=FR9dURViGkVP+PPMx2TIQihMVNbRpO+JtysSj/Bns+4=;
        b=Iy3ruMTovz9U4S8V5ENoCUBc8gC4TA6l+W+DWTTBzlWeE6slmx6QnwZTwZNtp5nhGS
         rPo6YNZu5ocAN8f1cxIplZ27w5gqfOxoyJuWpd48UaxNtZS86CKmAotV1Gnjc3AdQ4BQ
         mgDlEGUayOwHJTQUU7XcukmREp8hdK702KHhn0HQ3A/p3C8QSPu86gvJidM6bhBxrHAR
         khOxJZUyhiqa/pw8oGYTIe3OFFqksyoi42skn6NnC91yXeGrD0Is3L90UlSMworb2xy9
         aRE4cDuITJ6U824TX33MGnd1OWHj+jMHgYIH1I5U3w9nkadxuW/SKKLarNHKEq/dpckO
         ZHHQ==
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
Subject: [PATCH 4.16 18/18] nfp: use full 40 bits of the NSP buffer address
Date: Wed, 11 Apr 2018 00:23:53 +0200
Message-Id: <20180410212759.535570297@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410212758.564682823@linuxfoundation.org>
References: <20180410212758.564682823@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597399732880753270?=
X-GMAIL-MSGID: =?utf-8?q?1597399732880753270?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

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
@@ -71,10 +71,11 @@
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
@@ -427,8 +428,8 @@ __nfp_nsp_command_buf(struct nfp_nsp *ns
 	if (err < 0)
 		return err;
 
-	cpp_id = FIELD_GET(NSP_BUFFER_CPP, reg) << 8;
-	cpp_buf = FIELD_GET(NSP_BUFFER_ADDRESS, reg);
+	cpp_id = FIELD_GET(NSP_DFLT_BUFFER_CPP, reg) << 8;
+	cpp_buf = FIELD_GET(NSP_DFLT_BUFFER_ADDRESS, reg);
 
 	if (in_buf && in_size) {
 		err = nfp_cpp_write(cpp, cpp_id, cpp_buf, in_buf, in_size);
