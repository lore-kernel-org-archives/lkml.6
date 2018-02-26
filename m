Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsN/W3cC7osqC9KVMw221C6v069da9ZzWmePhzXNZdGsObxeqMCMcZlEIBAhm80C4XMlak+
ARC-Seal: i=1; a=rsa-sha256; t=1519676726; cv=none;
        d=google.com; s=arc-20160816;
        b=xzGN2tgVwlp0QzH255b34usmwPQNprMAomm0B+tqT29g2qFtwJPxa32WwSaKex+8Gn
         ZVhzfEjbEQiCIqcvS5YARimwIUtQu9AdhcqS7WNnx7xxdLjsYscJZCWWevUZs2iP9b9V
         sxz1zve5yv/5wZKpo9/DUdfSjatbKzLtra3h7scoxCySHjL1Brg/ZBX5jRnsMdgkvCC/
         xDjYvckBWjaSNxdbJYOY+qVUnmr91Zpu0T/wZhZET5ECeX33nxyQyooTRfcjpuFbZPSH
         Uuadb2zqEoTvp+XyezK2Qxkhkqh2PQOTHb+ZDv6gQP/FDwqEt05pM5rq7ykj6/LR0LC9
         LLIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=FXJhg8IuVYkbw5I9EUU6KXESrd4LXUpysHULgRmanRo=;
        b=MkfeguxqucV2fdXZPinQ9un5p3ZuHO+87YqWW1x/GHne7YeLtncU4EbtzB1LBz2D3W
         XKEDQ8aWg6EGmAm3kWWzZ0w9jHlVBdw78PD1n3uZVmhQ8vjeMzgs1vbmuklHd772Kz0v
         Wh6M5IPJB4MwzSkhNZBW7V0OtnKSjoRwzqCJPmeN2HALY6Tu0YjkcW3agBSp933qZma9
         jEcAqop7m+Fwzg36ufOywNrQC+owC1QApxWob1fEhwkr156K4KsL8sDhApiO2u4x9Tai
         HnLm4Ua54wJcKg2jCz5YYJBV0z5ATo0hc47r63PSVcBVOVarHc0CPsL5UR9QnbwKmD2X
         113w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Lukas Wunner <lukas@wunner.de>,
	Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 4.14 52/54] drm/amdgpu: Avoid leaking PM domain on driver unbind (v2)
Date: Mon, 26 Feb 2018 21:22:29 +0100
Message-Id: <20180226202147.352798805@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180226202144.375869933@linuxfoundation.org>
References: <20180226202144.375869933@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593496025366379001?=
X-GMAIL-MSGID: =?utf-8?q?1593496543193875481?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alex Deucher <alexander.deucher@amd.com>

commit 458d876eb869d5a88b53074c6c271b8b9adc0f07 upstream.

We only support vga_switcheroo and runtime pm on PX/HG systems
so forcing runpm to 1 doesn't do anything useful anyway.

Only call vga_switcheroo_init_domain_pm_ops() for PX/HG so
that the cleanup path is correct as well.  This mirrors what
radeon does as well.

v2: rework the patch originally sent by Lukas (Alex)

Acked-by: Lukas Wunner <lukas@wunner.de>
Reported-by: Lukas Wunner <lukas@wunner.de>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Lukas Wunner <lukas@wunner.de> (v1)
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |    2 --
 1 file changed, 2 deletions(-)

--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2076,8 +2076,6 @@ int amdgpu_device_init(struct amdgpu_dev
 	 * ignore it */
 	vga_client_register(adev->pdev, adev, NULL, amdgpu_vga_set_decode);
 
-	if (amdgpu_runtime_pm == 1)
-		runtime = true;
 	if (amdgpu_device_is_px(ddev))
 		runtime = true;
 	if (!pci_is_thunderbolt_attached(adev->pdev))
