Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225c3kl1PThJIxXLEGxjeM339NHwNb0DEfpxfQa9E5gUX+pKf/UTgMb4GyeMMzppWyPpERrq
ARC-Seal: i=1; a=rsa-sha256; t=1519412114; cv=none;
        d=google.com; s=arc-20160816;
        b=usUi2ey5F1Smkrn5tqbGpwDzZ210QHQoiWRdmeeW8Ol3cR+yKuLLN92ZuoR3z16Zo7
         +U02osk840i8S5SzK2uWUNuUMQSyY/hfftNMoOpb4B5ioSaOGVNjpA/9BxgfJBU7pDQt
         f0q/Bidy/UMWk12RE9a8VMKlELUYQ5uGIZrgaRpOEuLA7ukC27WAAKmV0koZacb3L7VK
         Y98IfJSy8hrudeshmc6AD9Rh938o7xswSnogKDxX+caUygiu34eu0U5gK+y0jweXf19t
         /QZngaX4Gc4b7OUR+6mEc157mlgNiuVJDNqG/aFYkLfA45YZLtVa3Ats7ORt+fZpAfX0
         kVdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=RY6hPgOGNQQ5W9ZrcK+hHPGse2mV6rCwZTwIceyYiEg=;
        b=Phl1ZA+dV8jPrgOB7zY98qbQCvpiQz2w9jCTKnaRkeI0bZ8VLGyjQwT6mByyHfjyiT
         uZiA70cR6Kdf4r4kjVWBWK0VEPYTUCgwwlWcUk4jJsVNDIPQDr2EfIRWCfbKzvPX4919
         uWsG71dwS10q7AJGPjrVjCFMABRP+R2vg3fDQtXpI2OXbQhMlNoK3ajqPyZCy/CWOP01
         8oDl4KHHII6Nnmk+PyF+w22UiAOJwc/mfy4xRK3HjnbZkvAMpev7/ksjL0r0fEQVk051
         v04FHmNS/CvDmRzsGA5T3hyVNpNPTETp70er7jEYTFfe7s/MlzbLSWQsKae72ueNhgDW
         DJew==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Dave Jiang <dave.jiang@intel.com>,
	Vinod Koul <vinod.koul@intel.com>,
	Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 131/159] dmaengine: ioat: Fix error handling path
Date: Fri, 23 Feb 2018 19:27:19 +0100
Message-Id: <20180223170758.957755619@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170743.086611315@linuxfoundation.org>
References: <20180223170743.086611315@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593217795962943006?=
X-GMAIL-MSGID: =?utf-8?q?1593219077452056197?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>


[ Upstream commit 5c9afbda911ce20b3f2181d1e440a0222e1027dd ]

If the last test in 'ioat_dma_self_test()' fails, we must release all
the allocated resources and not just part of them.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Acked-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/dma/ioat/init.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/dma/ioat/init.c
+++ b/drivers/dma/ioat/init.c
@@ -390,7 +390,7 @@ static int ioat_dma_self_test(struct ioa
 	if (memcmp(src, dest, IOAT_TEST_SIZE)) {
 		dev_err(dev, "Self-test copy failed compare, disabling\n");
 		err = -ENODEV;
-		goto free_resources;
+		goto unmap_dma;
 	}
 
 unmap_dma:
