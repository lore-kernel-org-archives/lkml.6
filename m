Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x226u3WUcNKNiHPat5mI9IM7c5mhXQuWOB2HU1NraYuzG+e8uA+D8UulvNvKoa2aibGl80yvu
ARC-Seal: i=1; a=rsa-sha256; t=1518709308; cv=none;
        d=google.com; s=arc-20160816;
        b=v7Q2P94S39AINFj3J0cDxnie+oBJUel5Hb+UBFFiHnH4DajgOM47k2n4w/QSXAsxXY
         hsdt9Yk4ZTuxEMLb48YnK0P/YpIa8vWQqY3PDSv0xjhM8VPv6eC2lXX2XEx1JA8oPsdl
         mOYZvAdzhzyQ4wLvXHg0yho+V0OSQsIDQCC3zWh4HrQt+NUIIEvUoS3vFYY2uhhng22x
         BF5HFJWYjVs2aFS/dxb7NovvdDiVQ1hdHK38W3YLC1B8fMpDCTN91d3QRSQcsjW8Nf4r
         4e0F8kxb3h+WPpVMQGx9oS8VBfYqB0L79stoQ92QvS5Kmq0iylqR5x03+h2usAa01ieM
         ekNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=gllUXNHXATY+54g5xiDHe8hhB4NOJl9G0abJ2D7xIjE=;
        b=Bnd8g1O/11rBLcLYwpjmbibtcMizssEuFiIjf6bmhV9NYdaycNituMsH04pS6R0wBo
         Kd7SAp5b4mQ544BpX14ZtjG5GmLFMoLcXMAcRPQkndr6Jpjarr2+9Pbm0VQPObu7MHGu
         bolM7T+BUvpRIJhOhAjxKjUE3RHHsGfHyYEGNbKN/NPhGpHamFZXUiTb4DKXWzpwAVww
         oUmqJrDUZfGBa3Jm5GM3ELLfbDA2aRj+oN0A1L0kho8w+99u7KR5AGMRQXtwCGGRI4yG
         GZTjhqsFl//FjNJ4DgMPB6x34D3ov+qUZIie12rkRB5frIxCglDf+Nv+lPHThwtc7UsH
         uLNg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Will Deacon <will.deacon@arm.com>,
	Jayachandran C <jnair@caviumnetworks.com>,
	Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH 4.15 071/202] [Variant 2/Spectre-v2] arm64: Branch predictor hardening for Cavium ThunderX2
Date: Thu, 15 Feb 2018 16:16:11 +0100
Message-Id: <20180215151717.205135826@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151712.768794354@linuxfoundation.org>
References: <20180215151712.768794354@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592481582898687532?=
X-GMAIL-MSGID: =?utf-8?q?1592482132006208497?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jayachandran C <jnair@caviumnetworks.com>


Commit f3d795d9b360 upstream.

Use PSCI based mitigation for speculative execution attacks targeting
the branch predictor. We use the same mechanism as the one used for
Cortex-A CPUs, we expect the PSCI version call to have a side effect
of clearing the BTBs.

Acked-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Jayachandran C <jnair@caviumnetworks.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/kernel/cpu_errata.c |   10 ++++++++++
 1 file changed, 10 insertions(+)

--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -359,6 +359,16 @@ const struct arm64_cpu_capabilities arm6
 		.capability = ARM64_HARDEN_BP_POST_GUEST_EXIT,
 		MIDR_ALL_VERSIONS(MIDR_QCOM_FALKOR_V1),
 	},
+	{
+		.capability = ARM64_HARDEN_BRANCH_PREDICTOR,
+		MIDR_ALL_VERSIONS(MIDR_BRCM_VULCAN),
+		.enable = enable_psci_bp_hardening,
+	},
+	{
+		.capability = ARM64_HARDEN_BRANCH_PREDICTOR,
+		MIDR_ALL_VERSIONS(MIDR_CAVIUM_THUNDERX2),
+		.enable = enable_psci_bp_hardening,
+	},
 #endif
 	{
 	}
