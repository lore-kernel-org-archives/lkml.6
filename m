Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELu9RM2I5nu1BdCe+UAI/51wdI4qfrLqJaYV4eBcC6DunyBKiqgS/aUQAS8exChDnxyrTuNe
ARC-Seal: i=1; a=rsa-sha256; t=1521483595; cv=none;
        d=google.com; s=arc-20160816;
        b=cjgTXQy1BDIzezV2GyJ0MAwsxqMnOR8Pfn7m7+9sb7fHdoIXyvnPwZkFxmf7E9qsr2
         NBQVCShfrisvZ4+UugVsS0f9scXF4V5f1BodAvVQ3bqZHddBWqh2CI2aNfZM6NhaincR
         4XsnNjeQ+VOSyZzyrxQ8qF/gUHVuDdwJDlyUcBMe+ZnAiM/O79Ra1g44TGVo5efwey3H
         IN1GTmvYwquQgDzCnv8/fSrY4UI4+XaAPq75aEGuRWb/KJspLFa6Bi9U79UdANa95ONs
         Hz0ImFLAMxNy2C6/+a1nNMSk8FJkldOPgg0VAE630oW0VOFYguDo/xQGyoLRRXifLFu3
         H8Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=4EXc9atMa+Dcb5zJfDyldf2p2yyNlkwL/o2QQ0rhwGw=;
        b=cqgfv+lMWJcWcJULpC9+oVZoWtuWs20F3DOU01J5OpFWmfXLzAunC/8VYcpmw+5q8W
         SsMkfQ6XmVPH+68L+R3cCwkLOHoXmS+GY+QmnlaVEZZXY4PSriUUYYi6KXnELViwm5WW
         gVBEcMkrmV9p1Oq3Z4e4JpDal30VdjC2qS+IOoTUuBlQBLz0Mfxa9V6gWS7E+I50p+4k
         CMThcYYJjxlso0WM4Aeu9JAwruq1wkkq8sblrrXLc6cs+nvw/VkldF+aPCcOGfpmpbV1
         hCcnSLFJFm6rqTP8o/oWjAYVN2kAeSKE/oVwgDP48AFnipD5KsnuLk1XRy5g473vPAPJ
         iCsg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Yuval Mintz <Yuval.Mintz@cavium.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 046/241] qed: Always publish VF link from leading hwfn
Date: Mon, 19 Mar 2018 19:05:11 +0100
Message-Id: <20180319180753.098855996@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319180751.172155436@linuxfoundation.org>
References: <20180319180751.172155436@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595391182345626727?=
X-GMAIL-MSGID: =?utf-8?q?1595391182345626727?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: "Mintz, Yuval" <Yuval.Mintz@cavium.com>


[ Upstream commit e50728effe1126eae39445ba144078b1305b7047 ]

The link information exists only on the leading hwfn,
but some of its derivatives [e.g., min/max rate] need to
be configured for each hwfn.
When re-basing the VF link view, use the leading hwfn
information as basis for all existing hwfns to allow
said configurations to stick.

Signed-off-by: Yuval Mintz <Yuval.Mintz@cavium.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/qlogic/qed/qed_sriov.c |   13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

--- a/drivers/net/ethernet/qlogic/qed/qed_sriov.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_sriov.c
@@ -3573,6 +3573,7 @@ static int qed_get_vf_config(struct qed_
 
 void qed_inform_vf_link_state(struct qed_hwfn *hwfn)
 {
+	struct qed_hwfn *lead_hwfn = QED_LEADING_HWFN(hwfn->cdev);
 	struct qed_mcp_link_capabilities caps;
 	struct qed_mcp_link_params params;
 	struct qed_mcp_link_state link;
@@ -3589,9 +3590,15 @@ void qed_inform_vf_link_state(struct qed
 		if (!vf_info)
 			continue;
 
-		memcpy(&params, qed_mcp_get_link_params(hwfn), sizeof(params));
-		memcpy(&link, qed_mcp_get_link_state(hwfn), sizeof(link));
-		memcpy(&caps, qed_mcp_get_link_capabilities(hwfn),
+		/* Only hwfn0 is actually interested in the link speed.
+		 * But since only it would receive an MFW indication of link,
+		 * need to take configuration from it - otherwise things like
+		 * rate limiting for hwfn1 VF would not work.
+		 */
+		memcpy(&params, qed_mcp_get_link_params(lead_hwfn),
+		       sizeof(params));
+		memcpy(&link, qed_mcp_get_link_state(lead_hwfn), sizeof(link));
+		memcpy(&caps, qed_mcp_get_link_capabilities(lead_hwfn),
 		       sizeof(caps));
 
 		/* Modify link according to the VF's configured link state */
