Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELt5rXmOzKh1YcNXG5km0aJ9DbrB6PZyiGIYueM/mh/CsOSdFHskoWnMqwKmSI9RXwJD3O3Z
ARC-Seal: i=1; a=rsa-sha256; t=1520955521; cv=none;
        d=google.com; s=arc-20160816;
        b=paqw6rh6GM3TaBbIRJRYKUYOpEffHyrT3jJYuHG1noilk/OEt1PTSaOA0+aaLhcYoC
         H6s//3BoBztzItD6227+lb83tgGVzlGyIZYcdNPPvhs9fUYicFrUc4Cx2TdpCojaT6KU
         mJ/6Ev+kMalXF4i9DR7Qe6ivCajFEFfL3/ER18EZ1fRUn5k/xDrM0pATOTQVoSE+yd8O
         qR1038XLm5hjPw/wsgmsi+v9n6Q5USNtgvFijFXK6lKE3ff/Vj7BaatKetXuhKAROHEQ
         7uVq8uK5OLRhXFaC6cpWCKtBwIjqI9dDOCVGHzF8MDv6mcbp3vQiXi9EeNan3J4JZH/+
         sIOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=dKqaGho5QKyKOMKZxo19NL170uYea5LCvxNn+Gsl4h8=;
        b=AGIbySEluFObTHVjZqdKzQenTIw6xLW3Wm8Cyw3Bi4Y5uq5XZTlI8uVl37LqXM2DVr
         Cp16J42MDVeGvGG8j7P7/duwfA7lghlqrutyHq0Un2ms3VvObv5rkdmNoIrG36xiX7wG
         2dpUxL4iPlyUGNWGbM2tsRlviaza4+jLgspQZiqYqJ4B8oNC9Gf8Eijib9DxQYTDhtt/
         1zxGTj0vee1XTOFUFR0TqtVPnttrQDLLE6AUbnKp8msPFqJhGz+bjN6Dmls4tN+OBitV
         3LEajFvZqHf8oQd50oe7JLuZqtdpjZ00bjXqGwK0+klQRFpH2YRLab8JAJOFefygNkzP
         Z2gQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Alex Deucher <alexander.deucher@amd.com>,
	Rex Zhu <Rex.Zhu@amd.com>
Subject: [PATCH 4.14 073/140] drm/amdgpu: Notify sbios device ready before send request
Date: Tue, 13 Mar 2018 16:24:36 +0100
Message-Id: <20180313152503.081983970@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180313152458.201155692@linuxfoundation.org>
References: <20180313152458.201155692@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594836847207625734?=
X-GMAIL-MSGID: =?utf-8?q?1594837456426051919?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Rex Zhu <Rex.Zhu@amd.com>

commit 1bced75f4ab04bec55aecb57d99435dc6d0ae5a0 upstream.

it is required if a platform supports PCIe root complex
core voltage reduction. After receiving this notification,
SBIOS can apply default PCIe root complex power policy.

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Rex Zhu <Rex.Zhu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
@@ -540,6 +540,9 @@ int amdgpu_acpi_pcie_performance_request
 	size_t size;
 	u32 retry = 3;
 
+	if (amdgpu_acpi_pcie_notify_device_ready(adev))
+		return -EINVAL;
+
 	/* Get the device handle */
 	handle = ACPI_HANDLE(&adev->pdev->dev);
 	if (!handle)
