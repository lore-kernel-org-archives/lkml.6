Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227U/aP6m0/atoozTN9ySpSFBELoMT2y+PTeqxicS8fWnyMSS0nhRVT1HAWIpW9jgg1Ya7n7
ARC-Seal: i=1; a=rsa-sha256; t=1518708367; cv=none;
        d=google.com; s=arc-20160816;
        b=MqrSPMd3FA3no3I3kUEM3tYZreAR7kYDPlHPc6rEmLCYAmz+7ylDqWL2rB5yxIQ/J/
         0244Hu4WVN2VYvMgR5TAh/+UlidMncnS1wHiDAGPLw1ofm6qbnjDvG5b4PBtCDJwBx4M
         mN0ExsQ7MzWcReIEyD9Vp8TNsK6NEjre607DkT44YVYKOfQo/cqFoK7RqR56gmdY3oLo
         oW6yLfRjyvDCktBkXZ2/EBUX0M+v11uDw22rf1AF5j3HusvRSUR/jRfOvfqC/G99q8ZB
         ToMQjBFG7Vv4sS9kg6Dg3QLF8ni88UUsPITt5zCc6h4lK6BeUY3KG8IhIij3M4xYHCV6
         GyIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=mJ+zxyCcP591WvfHaFRTZacIjTgsfQlTpZu0Gm7GSNM=;
        b=LR9jHMxd8Yt7BafMqAcEQnxIr5LLr2+PYBW5KIgJtGkn288e+YD58TbUn0CkGtyNYG
         Wj2O1I+J/FRt5HhThUGp4jt6MivX27v2Mtaex3AxjOaAd0IIz8Oz64IYDFsqzSZXZ3wh
         WidK5c3FOB2pa/FiJs84mdky8e3HpbTKr/FuScAlfOXR+q0F0i2pcVidfwmKZ8FptvNo
         G4/6CNKMBJjvdpzrp4DRlsPMhKqErexkpV21sPHVxo/6lR7c4RMNbcLfpU15+8ACR8A7
         cPtnBeg/RefGmDc2p+wV7MQ6cF+46B+RYdJhSjKII3yenHoR06gRJXDlG6op6D98+qeC
         hE0g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Daniel N Pettersson <danielnp@axis.com>,
	Steve French <smfrench@gmail.com>
Subject: [PATCH 4.9 03/88] cifs: Fix autonegotiate security settings mismatch
Date: Thu, 15 Feb 2018 16:16:30 +0100
Message-Id: <20180215151222.947185375@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151222.437136975@linuxfoundation.org>
References: <20180215151222.437136975@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592480805099835569?=
X-GMAIL-MSGID: =?utf-8?q?1592481145246979614?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Daniel N Pettersson <danielnp@axis.com>

commit 9aca7e454415f7878b28524e76bebe1170911a88 upstream.

Autonegotiation gives a security settings mismatch error if the SMB
server selects an SMBv3 dialect that isn't SMB3.02. The exact error is
"protocol revalidation - security settings mismatch".
This can be tested using Samba v4.2 or by setting the global Samba
setting max protocol = SMB3_00.

The check that fails in smb3_validate_negotiate is the dialect
verification of the negotiate info response. This is because it tries
to verify against the protocol_id in the global smbdefault_values. The
protocol_id in smbdefault_values is SMB3.02.
In SMB2_negotiate the protocol_id in smbdefault_values isn't updated,
it is global so it probably shouldn't be, but server->dialect is.

This patch changes the check in smb3_validate_negotiate to use
server->dialect instead of server->vals->protocol_id. The patch works
with autonegotiate and when using a specific version in the vers mount
option.

Signed-off-by: Daniel N Pettersson <danielnp@axis.com>
Signed-off-by: Steve French <smfrench@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/cifs/smb2pdu.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/fs/cifs/smb2pdu.c
+++ b/fs/cifs/smb2pdu.c
@@ -585,8 +585,7 @@ int smb3_validate_negotiate(const unsign
 	}
 
 	/* check validate negotiate info response matches what we got earlier */
-	if (pneg_rsp->Dialect !=
-			cpu_to_le16(tcon->ses->server->vals->protocol_id))
+	if (pneg_rsp->Dialect != cpu_to_le16(tcon->ses->server->dialect))
 		goto vneg_out;
 
 	if (pneg_rsp->SecurityMode != cpu_to_le16(tcon->ses->server->sec_mode))
