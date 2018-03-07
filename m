Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtk5JoAPDRcXOZ2Mt3HZndT2Ny2u1cDBxJtO8jFNEFmOaEnkMtkU9gqctJ+i9ZSTFZc2eTm
ARC-Seal: i=1; a=rsa-sha256; t=1520451636; cv=none;
        d=google.com; s=arc-20160816;
        b=xXgvaSwREPahXtvLqDMW6cA37sFW27XJU7u+6NksiEOdAbts8KmA4WwvKGJg776umf
         lB5y08DwgBmqsAY4wIIQSpo6XZpvBGWSwLmGoh/QFYtbGHoaqtP0EvRWr+RPZEv80TJt
         S+/baB4PVsuD+QnUHN2UT8Xs9kqX00rn5S59UoJYEEGnwFtwHR0epCsyl9NQ+FkikIKk
         EIyIA52MQJNDEdrN/CV11jiH7MgmwEEnC2JwruaBDTP3sL6eFJ/KqhYYUjP80FImzns8
         AZIgSbmdHuULhQn4SJvJxfiAW7lXmrRiEIdutaKjV0fsRDTDJPw9Debc0C/qrzW4wcgR
         oXTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Vk1TkctW6zYNQCTBCqIIhjnvdcxUGeIcUUGIOqiLtPw=;
        b=twPVbpAfehaZIc7iRGkkx2YYME7Hjmqs40gMUnXB9gcFh7jfJVULn6Wbc1ECYL1/eG
         Xf2PYwN/yOjeJCmF6SqUaE8ng6H+Wu757OgdBwyH5jUPqCZt8YJ6vdFJEJw3sRZX5Wd3
         DNbNb5Nk1U+bVBCmaeyl2KiPWFGd1QCNH4eUwfTu83FeWxJB7HdNVJazJheu2nSDGdDW
         Uo1nQakEt2kqvLkfwVwtcOK5xkvqZ8HDETsB5FRxPiAyQdCp3k9wBIKBOHF2Q/lU4Zos
         bMKDFsaANRIdarHBs2Bnqt/vIE9oHs1XrNVLKyXpF7s8ZUwID57/cqSBAeCOpVPV/4Ci
         BEfw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	David Binderman <dcb314@hotmail.com>,
	Corey Minyard <cminyard@mvista.com>
Subject: [PATCH 4.15 003/122] ipmi_si: Fix error handling of platform device
Date: Wed,  7 Mar 2018 11:36:55 -0800
Message-Id: <20180307191729.707864167@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180307191729.190879024@linuxfoundation.org>
References: <20180307191729.190879024@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594309094853096955?=
X-GMAIL-MSGID: =?utf-8?q?1594309094853096955?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Corey Minyard <cminyard@mvista.com>

commit 174134ac760275457bb0d1560a0dbe6cf8a12ad6 upstream.

Cleanup of platform devices created by the IPMI driver was not
being done correctly and could result in a memory leak.  So
create a local boolean to know how to clean up those platform
devices.

Reported-by: David Binderman <dcb314@hotmail.com>
Signed-off-by: Corey Minyard <cminyard@mvista.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/char/ipmi/ipmi_si_intf.c |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

--- a/drivers/char/ipmi/ipmi_si_intf.c
+++ b/drivers/char/ipmi/ipmi_si_intf.c
@@ -2045,6 +2045,7 @@ static int try_smi_init(struct smi_info
 	int rv = 0;
 	int i;
 	char *init_name = NULL;
+	bool platform_device_registered = false;
 
 	pr_info(PFX "Trying %s-specified %s state machine at %s address 0x%lx, slave address 0x%x, irq %d\n",
 		ipmi_addr_src_to_str(new_smi->io.addr_source),
@@ -2173,6 +2174,7 @@ static int try_smi_init(struct smi_info
 				rv);
 			goto out_err;
 		}
+		platform_device_registered = true;
 	}
 
 	dev_set_drvdata(new_smi->io.dev, new_smi);
@@ -2279,10 +2281,11 @@ out_err:
 	}
 
 	if (new_smi->pdev) {
-		platform_device_unregister(new_smi->pdev);
+		if (platform_device_registered)
+			platform_device_unregister(new_smi->pdev);
+		else
+			platform_device_put(new_smi->pdev);
 		new_smi->pdev = NULL;
-	} else if (new_smi->pdev) {
-		platform_device_put(new_smi->pdev);
 	}
 
 	kfree(init_name);
