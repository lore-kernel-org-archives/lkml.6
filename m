Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224EIrgD+tiOlgKWyCoHCQvnJZjYHmNZk3LZkIOuXJrB8SwPyI3fMv3H8hDPdtYDcIQybhX8
ARC-Seal: i=1; a=rsa-sha256; t=1518708967; cv=none;
        d=google.com; s=arc-20160816;
        b=WZ1Wp5ZUxthjAv/fBkZLZnBCfpqSZroFPCTA5rka7qqhZI0VMJo9u8bCE5F4TBZsKe
         LgTeLVvPIcMmCOAKtKqJ4Qpc4MiJkBCxozyAc3CedsVnbb3KNn17lYy2i1Zj/G7stOxb
         s4zgRmb/mBxoiMXBxp/CHNo5dhjkjDuZjIwwUwfymUxDRKv9LuxNxYWuMG1k1x6H3jtn
         lRfL2jnhFf68dw4tIokplGCknTqhSa2C/2PJQ6Oi5y0FOzV1liONNxcod3LRZi8sBR49
         JX9vy/nUrmgenRBm03bmW63nbaMz2uslmOm7GOaDe9IUoEx8FDojI25LsXD5jly01FoK
         hnXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=2lKVK1D63qNfS6773oS1DsUEMJCwCR66blJzW34wVe8=;
        b=UFa0KYsyhN6aEaOwCgaNv2veM+ggwD3ViefXBRG6Tzb71qf5kdAFSQsLId+BvoMmxc
         WT0wu6QPiP9clQ5206UHJM5JuhtJHEjZLcCvQzAas9b4BdaRy8O1bYKhs8c++QDjOMuJ
         TEnhhPejr9Ob1Mcs+GUlsbBa/hXP7GWS12qxzi7VE6DE7k8VRHNx9Of239UkhJPhOl0b
         xjqtcXDDa+otUiEOTlSnsLLp92v2/KOgqT2lgej9t4F9Rcu0C0mBfUkWBppIziJ9yqYE
         /OmvLlXT/51dCLq7s5tofQxvArgJqiP9NyL3R8HgrzZNbeHSu/ldZmbouK27n6Ba3Cha
         yeeg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Takashi Iwai <tiwai@suse.de>,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH 4.14 144/195] ASoC: skl: Fix kernel warning due to zero NHTL entry
Date: Thu, 15 Feb 2018 16:17:15 +0100
Message-Id: <20180215151713.006045366@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151705.738773577@linuxfoundation.org>
References: <20180215151705.738773577@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592481262920036706?=
X-GMAIL-MSGID: =?utf-8?q?1592481774941078579?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Takashi Iwai <tiwai@suse.de>

commit 20a1ea2222e7cbf96e9bf8579362e971491e6aea upstream.

I got the following kernel warning when loading snd-soc-skl module on
Dell Latitude 7270 laptop:
 memremap attempted on mixed range 0x0000000000000000 size: 0x0
 WARNING: CPU: 0 PID: 484 at kernel/memremap.c:98 memremap+0x8a/0x180
 Call Trace:
  skl_nhlt_init+0x82/0xf0 [snd_soc_skl]
  skl_probe+0x2ee/0x7c0 [snd_soc_skl]
  ....

It seems that the machine doesn't support the SKL DSP gives the empty
NHLT entry, and it triggers the warning.  For avoiding it, let do the
zero check before calling memremap().

Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/soc/intel/skylake/skl-nhlt.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/sound/soc/intel/skylake/skl-nhlt.c
+++ b/sound/soc/intel/skylake/skl-nhlt.c
@@ -41,7 +41,8 @@ struct nhlt_acpi_table *skl_nhlt_init(st
 	obj = acpi_evaluate_dsm(handle, &osc_guid, 1, 1, NULL);
 	if (obj && obj->type == ACPI_TYPE_BUFFER) {
 		nhlt_ptr = (struct nhlt_resource_desc  *)obj->buffer.pointer;
-		nhlt_table = (struct nhlt_acpi_table *)
+		if (nhlt_ptr->length)
+			nhlt_table = (struct nhlt_acpi_table *)
 				memremap(nhlt_ptr->min_addr, nhlt_ptr->length,
 				MEMREMAP_WB);
 		ACPI_FREE(obj);
