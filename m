Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELt/8E8BEcw4CX0WuQDdn5qhR+HnXg7MkAuhpUzd/JANpf3MhYtO1P8ulkMRJz5EfFJuXUv/
ARC-Seal: i=1; a=rsa-sha256; t=1521214957; cv=none;
        d=google.com; s=arc-20160816;
        b=0nimM0wXdDQOmQhmMoXYGoc8UdEi/FCJ16xQped+JVPhIMkVEOUNdTP9f6bUYCiHn+
         a12BHGhFCNUQCG0BUqc4iKihBsAMZvxGbeS/gPB9XcEnisMbsBy3Seq6OOxHAvODGbFV
         8kq+N1vzvXrEmHqFDKRSmOo/BZ5K6m/XoFINh60WH+x/SjI6SkrN9qKfcLyhwKCY+InA
         auv1gBcNbv9MDdcQCTozd534V6xsknllrxFU8tj93L/J7aUWsIJGEZ/62pGUCQNCaLxo
         HYca0vG0Faq30nSwATp1zZmGJi8R1sHZ4tGZbbojQypU1WFkW6sgnMKQPU5TYZAZZvR0
         zV5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=JiZZYjhH6p4gugeK/SQlZYoYTqiB0UHxr+3PSGQGrDI=;
        b=pXTPGStX135LfK2+f6IFRxVhDvv3yMi+YQqibJaYg7QFle/KHv1Vvr+vR+myjwv+Lk
         7UOlwDz4ZtqP8fYFNRnSIc2L9V5M9U24Gj/+069v5DIERhbkSbFjiZbyzLOSP+upzvVC
         kUyQUkK0R17oVJYiAdtewrIIQUZnSnURXG623UbbgjgDSPdctew1QFAf8k3Pt0SAnsCO
         eDuyX0xsRulGV+IM8ZWKSX7bDfYkRaKYzpoBvJXAkiqKy+kKw1W3eKxIDobbN+dJN32g
         2b8nacN/gPZ4hecwzAgfSER79DYXlS1p/t1r3kCj9c0cjv8LvqCbXghOSd1hdXk/aMOm
         KsYA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Felix Kuehling <Felix.Kuehling@amd.com>,
	Oded Gabbay <oded.gabbay@gmail.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.15 041/128] drm/amdgpu: fix get_max_engine_clock_in_mhz
Date: Fri, 16 Mar 2018 16:23:02 +0100
Message-Id: <20180316152338.800080136@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152336.199007505@linuxfoundation.org>
References: <20180316152336.199007505@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595109036390378967?=
X-GMAIL-MSGID: =?utf-8?q?1595109494915200515?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Felix Kuehling <Felix.Kuehling@amd.com>


[ Upstream commit a9efcc19161e20623c285fac967a32842972cebe ]

Use proper powerplay function. This fixes OpenCL initialization
problems.

Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
Acked-by: Oded Gabbay <oded.gabbay@gmail.com>
Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -265,6 +265,9 @@ uint32_t get_max_engine_clock_in_mhz(str
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)kgd;
 
-	/* The sclk is in quantas of 10kHz */
-	return adev->pm.dpm.dyn_state.max_clock_voltage_on_ac.sclk / 100;
+	/* the sclk is in quantas of 10kHz */
+	if (amdgpu_sriov_vf(adev))
+		return adev->clock.default_sclk / 100;
+
+	return amdgpu_dpm_get_sclk(adev, false) / 100;
 }
