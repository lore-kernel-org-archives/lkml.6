Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtK5rTez3tLVIjs2gh4DNZF0aUoGeMJ0I9R+S/iYo38DBCnXFvmxc5RVALBgvrwXJJgehNl
ARC-Seal: i=1; a=rsa-sha256; t=1521214519; cv=none;
        d=google.com; s=arc-20160816;
        b=z9id5VNTfyI/eAyqu2xJxhB6Kv8gyVWd0g/xL99AAxIbPOUFC2hqMT3Djq8mJGnUKG
         eGP80LoYpAtfO+dQ9okboNivXfOqheIUB17ipj4L7S4KUJe9v14G9oWTpS29cQoLB5Gr
         WFWS25Z3LV9LDXq4k8sa3UolVA/WyBbQFNSpDK3sXkc8yt4c+8yd6eRPzGIjyauwawGr
         rvBucnQI9OJMXoMQjmRpTIMVm/b+B/Wk5AjHRJEgYPzmTFa5LmngwbXyFFLOfnv9Ms4J
         OneZAoJT1rC23cnp+rNjP7tRjQVmoYXSBhnYOraeKPETTKZDSRwdGrFcHAFGuNejOJYl
         Bgxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=r3cMkc5ya1i+CgJwj/bO725ODuOU9S1MPTub//lnAA4=;
        b=MkF6+PuhkUt1H2ooPby1OXdQZ5LVdivAxNYD9f2P76/xd7uz9quYFsQa/wlKqJ7Asz
         q0F6LJr2hu/Tt5Yjy0YoXX6AVIjWUSqP/s7X3j8DCb3XYVMQra891A4oy6WVRQjp9E4Q
         QV4sWU2riHiHj0sJC5T4/EH59JmBhnAvyHImj6XS2eQSyYlUtZNV6xxDgkGwqTwT0OgU
         Im2kEZbPvS55Ij3zbV7vQ/dhHxebTXzxqCXMSVGOJjKgMsx6xGnQFLYaBOZR9uoobq+i
         yRlmWCxijedQxN3fU8Ua7n8fcsshG1AWpg9lLbUPKzyaVtBbohMuiDuDCGHwsnm7zM5S
         ElSg==
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
Subject: [PATCH 4.14 036/109] drm/amdgpu: fix get_max_engine_clock_in_mhz
Date: Fri, 16 Mar 2018 16:23:05 +0100
Message-Id: <20180316152331.913173753@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152329.844663293@linuxfoundation.org>
References: <20180316152329.844663293@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595109036390378967?=
X-GMAIL-MSGID: =?utf-8?q?1595109036390378967?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
