Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48nduYAcrQOcKvXQ9ZfQA328lbDLslbFDzMfepnMgPWwYJ+5qp8qZnSgU/5slYYmRBtOTuX
ARC-Seal: i=1; a=rsa-sha256; t=1522168338; cv=none;
        d=google.com; s=arc-20160816;
        b=dd0KbC09lCBeR1c07DJcDaPgc5DoyBoEss0I/K0/HOelbSsE7LBMtCeiAWmmkqRlxM
         XRffoegbP/NVTbvAazyH0Anaa95bWfHBHCEvZAM/Srxvymbjaop9jGohY9MAQ3MnD0+e
         CuLbuPscDxud65h80tdW5eVu8poLvWmUeDRpgvSQRIWkcrxG0buTyu6GDKWibPwBZtFR
         1yQ6+owTMZNj9WJDAe3CvNOEMHlRapokbnRreli1CIHQx8i8ziogIN2dxC3q0rOSSbrG
         vQl8FhI8wMxaz6ingzFVoYZXd9Hh/sAIUFVQuWp2ukeJ00wXdpy7zfizCFdbXt6b2FIN
         6YHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=2LB1FvTCvZ5HaqzWrOZ1FjZUqRUnGraEa130GDqm60c=;
        b=TqgkBtxK1IKClyO0eAdJkq8EypC0exHeXyJKdp8pu0hNTYyn1lEQgktTdbATX85gxd
         manxe28+R6xY/M6sNTkpmeal8//ALUMdVa5Wfep5+WrCvAjTWa6xeRcROKF9tMzTZF9k
         kyNHidUl1gvA/ITgdu2lPtpwdni4mEIVsLQtEzC2eLYBeXr5STIT/aG8Jz5utGNM58tY
         VCExYKTpdqrNwWFszzu4NayqSOMeK/NmU6VqvxXGcZVfky+9Sh8hCqaUvP/N8ZfdL+sD
         z95bgXVeSzepJ8Dk5zRy00+Wtf+39zrqX1A4dDEZAg/nXMjU11YVNwyb43uFgHqS/+7c
         6d2g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Park Ju Hyung <qkrwngud825@gmail.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 4.9 19/67] libata: Enable queued TRIM for Samsung SSD 860
Date: Tue, 27 Mar 2018 18:27:11 +0200
Message-Id: <20180327162727.817056943@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162726.702411083@linuxfoundation.org>
References: <20180327162726.702411083@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596108977196194202?=
X-GMAIL-MSGID: =?utf-8?q?1596109187593822687?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ju Hyung Park <qkrwngud825@gmail.com>

commit ca6bfcb2f6d9deab3924bf901e73622a94900473 upstream.

Samsung explicitly states that queued TRIM is supported for Linux with
860 PRO and 860 EVO.

Make the previous blacklist to cover only 840 and 850 series.

Signed-off-by: Park Ju Hyung <qkrwngud825@gmail.com>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/ata/libata-core.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -4422,7 +4422,9 @@ static const struct ata_blacklist_entry
 						ATA_HORKAGE_ZERO_AFTER_TRIM, },
 	{ "Crucial_CT*MX100*",		"MU01",	ATA_HORKAGE_NO_NCQ_TRIM |
 						ATA_HORKAGE_ZERO_AFTER_TRIM, },
-	{ "Samsung SSD 8*",		NULL,	ATA_HORKAGE_NO_NCQ_TRIM |
+	{ "Samsung SSD 840*",		NULL,	ATA_HORKAGE_NO_NCQ_TRIM |
+						ATA_HORKAGE_ZERO_AFTER_TRIM, },
+	{ "Samsung SSD 850*",		NULL,	ATA_HORKAGE_NO_NCQ_TRIM |
 						ATA_HORKAGE_ZERO_AFTER_TRIM, },
 	{ "FCCT*M500*",			NULL,	ATA_HORKAGE_NO_NCQ_TRIM |
 						ATA_HORKAGE_ZERO_AFTER_TRIM, },
