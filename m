Return-Path: <Vijendar.Mukunda@amd.com>
X-Google-Smtp-Source: AB8JxZriZ5aVcBzVsmF5QjQdgwz9qiqmW2uFQu3V0TG03I0IKdq4UhUjLU8cQgcEzgjKcs1N85sm
ARC-Seal: i=1; a=rsa-sha256; t=1525207731; cv=none;
        d=google.com; s=arc-20160816;
        b=JcvM6TqIHoDMSqCDgTgk++uCBAD8nCsTtTp0ry6zgC/9LqN71hT1xHHTcFm7wbFWY6
         ew3iHRYRnbpddA9P68W024jY51Mrxic0Y1FzKfkslWUN4LGu5PKSuNXMvWC90Leajla4
         xxMOO5tqkevrG1TvUTn5rf2085Sb4ctjDj04gr2R9PPLQsPFWYHiuswfGzo6EYuratzB
         CXGAHzxWx0ysy6ZDfPv6fsJEutXgRZWiQGdfo+7gZsV4M2W8INA49f7fJuhFEC//8m3y
         tFSs4auvD/GSq51+/9dQa/mS8NE/4x3e1uN8s04qmApdLZX8o6yG1cRKFYOS/lux7ZPr
         4Nbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=bl0GQPvHEDwTxrsDh7bvbFOHIRUXS3eDSkIaPPTUWcM=;
        b=YBPEzKu3lmDA68krZIcO3N1RJpnv3wFJ4W00dXl9n3dcWTJEYsysPWEfTyNLNAImMe
         tNNEJSI96WKbuQoPQ+rO+5XOwE++IqCIo3fN+R7IYKGYi/PkjoUdC99AlMPFZXrJbzHu
         219tAT+oq5AHvRhqva3yeWx4/384MVqV+C3VmHWmOHRdVxzxwVW8f7ecqIjYK1AHlx5K
         swqrP56k74YfnlTi4N1Q2eFfH3hRF/drhmtA8L/P79+FIEVrua99d/xK1Ywx2S2OxZD0
         ROcqNJVqFWcxOdBIi3SG6v7aMPE3riSsDHDZ7Fcnryfv3wgT2hD4beQy7g10hH9pHIn0
         1f+g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@amdcloud.onmicrosoft.com header.s=selector1-amd-com header.b=GaA1OTT4;
       spf=neutral (google.com: 104.47.37.51 is neither permitted nor denied by best guess record for domain of vijendar.mukunda@amd.com) smtp.mailfrom=Vijendar.Mukunda@amd.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@amdcloud.onmicrosoft.com header.s=selector1-amd-com header.b=GaA1OTT4;
       spf=neutral (google.com: 104.47.37.51 is neither permitted nor denied by best guess record for domain of vijendar.mukunda@amd.com) smtp.mailfrom=Vijendar.Mukunda@amd.com
From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To: 
CC: Vijendar Mukunda <Vijendar.Mukunda@amd.com>, Liam Girdwood
	<lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela
	<perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Alex Deucher
	<alexander.deucher@amd.com>, Jason Clinton <jclinton@chromium.org>, "Akshu
 Agrawal" <akshu.agrawal@amd.com>, Guenter Roeck <linux@roeck-us.net>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Thomas Gleixner
	<tglx@linutronix.de>, Philippe Ombredanne <pombredanne@nexb.com>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, "moderated list:SOUND - SOC
 LAYER / DYNAMIC AUDIO POWER MANAGEM..." <alsa-devel@alsa-project.org>, "open
 list" <linux-kernel@vger.kernel.org>
Subject: [PATCH V2 03/10] ASoC: amd: removed separate byte count variables for playback and capture
Date: Wed, 2 May 2018 02:19:57 +0530
Message-ID: <1525207810-1305-3-git-send-email-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1525207810-1305-1-git-send-email-Vijendar.Mukunda@amd.com>
References: <1525207810-1305-1-git-send-email-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(396003)(346002)(39860400002)(39380400002)(2980300002)(428003)(199004)(189003)(68736007)(186003)(6346003)(126002)(2616005)(81166006)(476003)(7696005)(50466002)(51416003)(50226002)(76176011)(356003)(109986005)(336012)(1671002)(8936002)(81156014)(39060400002)(77096007)(446003)(478600001)(426003)(53936002)(11346002)(36756003)(486006)(86362001)(72206003)(4326008)(16586007)(105586002)(53416004)(5660300001)(26005)(106466001)(47776003)(104016004)(8676002)(6666003)(48376002)(7416002)(97736004)(316002)(2906002)(305945005)(54906003)(266003);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR12MB0327;H:SATLEXCHOV02.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoDomainNonexistent;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;DM3NAM03FT051;1:ub+4ExJWaOmCCz5GyceQTrmzdhQcxIVlINp2zfftJsrAh+yi8N1n8V182LpLMBkOsTF+dwP44AUMQgSdWraCrZeSsfAcD3BSJiG1U5MXp70FlU6F4N6wMsmZR+U5O0sy
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060);SRVR:CY1PR12MB0327;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR12MB0327;3:oTliVrqqWIpvW/SnjKbTAJbUCrsykx01L4HwejzSRNdtSvsJYLe9KbY+IbreWusIywak2G3WzmRLP4lnPFgPYa6stj0J6uU0vZVNgd/ncvKNVcqA21lFu5Yw8vrk7RifFIG9V3u7msj974Sss4oKkRyZZUM8PmoOt0RTFx3T68/w153GlzQtr+qlDUX02sjrjBF6JgYnUrPC1iAHSPD2R+uAGOexgtRj6oF5UmctPsXsQM3KDDgog/yiA+Qdt04Vc6eIgTIXZRlmynEYdXrII1qrcblE0YjiskPNYokM6IDX9kjiULDgf1pnDP9BQidk1PsKv+qB4nX8f+9KG5b5SKFitttUQbO6qSUy2KlIzyU=;25:Vst4MCXs1smzcSicKf6K/1FyZqRDSkqbVNJNgRz/IGtaQTdWR91smvp6tZpmUWelHdD9XMYcYlXxJFOvoq5Nd3MnnuamiCiM5DfnV8OBg79IoedI80HroaL9k0Ru+QwIsHSlIog5OsaluQHwkuxOlppnkd59lRfqsSBhGBnCEUitVvnbQ0dR72WTukQ/fgPy6vPM37h7J+6ZIpdFPGDPZ81j2ePQDDvtq/kIFnQeacQ7lXWGBQQs2GtyfShTDREmO8l5nlI61Q1ThdjjmLTgVja9nZGyHuzDwKwLMUQRnWFE8YbiAQlZ3Js5cz74/bawLwvN1AnnfvIuhIjzQC8QMw==
X-MS-TrafficTypeDiagnostic: CY1PR12MB0327:
X-Microsoft-Exchange-Diagnostics: 1;CY1PR12MB0327;31:s4fWCQoeAz9nxRFLtsA8KAgGalLPgIv9TTK62prCxqcDoPJG6SYZp/vaCwY7ShLqZIC+An+VynsgHtb4W6GPAlxSxLKjQVHREPB29WbLzrMx8tRyMz8dEwkK0lY1x612KjeTTbY3Zij91DTP71W1ywIxwE7NF6D8yhBTjdB3FlwSUB8+Wok4Pg8TrI7wNgdbuUN98+3jWwwl622LMjW4FtmlITruRowixiB0CzxwFkc=;20:fj0BvPmte2k2pgJ95hAoKcG/If9O5sEV2UvNfR914eVDXnow/36Of7ryuAN+7JThK9FG5uZh94sBHWTJudF8kOhPKJr2I8P9eA0/Rrh6MdvTI1+lwPj+nIvrbgDoDxwAFl1nqxnSw9Nq6Z4+pUmsD6/wj0kFrJtHzA7+KA0aCReMQu7UCg+Mx5u93XCEvv+VRYbQbuCpLUGmOv4Ij3XNsBbT/vjj3SjSqmqccoExxp/LfFIlPsG8LywGeOHFIu0N3+cW+c0GI99XEGR1na8uBfcQnLXAjCxeKmE4XwnhZ+LEYhTprcXo8l8q6RjuPhikRbHS6jqnAev9eXBl+rW4dw74/AjIbR3LfALZN1lqKoBX+L18NzwTaXapwaV3Rl6phFnQmz5D1QNNinTklo5ZLAcTLEJlmZ+UCa1xnMZ/wYUdLIEu603TSxpgMHzl1Hm37nfR/m8TaTU1vfF/URFHemuLeagxM1jVMAUZKehBP/wnj48KnoyhVsVBtdnkIx2n
X-Microsoft-Antispam-PRVS: <CY1PR12MB0327F02ABD2F2FCA7CC16CBD97810@CY1PR12MB0327.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(10201501046)(93006095)(93003095)(3002001)(6055026)(6041310)(20161123562045)(20161123564045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:CY1PR12MB0327;BCL:0;PCL:0;RULEID:;SRVR:CY1PR12MB0327;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR12MB0327;4:RpgWbz5+dM7nx6eM7E4m6fZCtuzCVU/kCtPWNzeGsg+qAKPrRZKwTYBFcQfvGt6IEGroFCSUvx7RxnoDn+Mw+8NPHcI4ksZIFDPFqUBNHSC47H/1v5R6NlqniikWIh345uAnU4L2CLV99BS8JBhzO7u1Oe6pxEr3eIcTxuafxQXamjLj+3SnxDDKhHphomsVjv19+1uuLgDASXWSSJVMyWqFDJugHAgjU8Je0I0bjSLKUSUaUrysA/j45Gd54jtgyTS2lWOl3rqKH/0eHuZwZ8hpqmfXQYwPFV+KCtu9g9DpAxOczud4M401pcZYoOZ/
X-Forefront-PRVS: 06592CCE58
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY1PR12MB0327;23:0PgEEZe4ANfjGU8UhwMGldRhE9eHTHJvnpiQGfR5f?=
 =?us-ascii?Q?z9pLcwRJ+DK2Dhmh33HTQC+ItXJBGNE4deMD7eETB77RNQH3HeD60wdLPD2s?=
 =?us-ascii?Q?il4OpuZvzspV4tq6zlY2cV9MGcT+Bp5iohJVqYxraX5tKp2575x2VWH6s86l?=
 =?us-ascii?Q?e+27IyTOppO7/mJr5qftGtf5aqMjKBo1W+3aG6ddogAT9ymnEjjyY5ApInJW?=
 =?us-ascii?Q?uEg82hU5abNAa3UnmE8/k5V4B/T0hUM5tqqepPy34xYv3E34u7icXTLutrSY?=
 =?us-ascii?Q?3rmUNjvnlfKu5+B+OQoW5/pGa6wDiQQQCif++7/N9kuBFlFdd9aroppgtm7j?=
 =?us-ascii?Q?rErzLU9eLioC3dBz48JfMZm34O8IBI44dV971NoSe8Uxdw9iyyBFlIxGvSKr?=
 =?us-ascii?Q?278MmHlMfqetJA1r0neJ0N4gvZgImREEoGKLBnpoz737Ud9+WHYMqfFh7GI3?=
 =?us-ascii?Q?qeMdUkfT8Eocd1imzSOlc8K5ZNXYYoPUqIRIK2Ewg2+NXIY0sjWTuicfKJIn?=
 =?us-ascii?Q?5vIrL++EnV6kh87EXq1JhhOrlAvIAVpgPcFycAHeeK6ExL9/93V50OojGeGK?=
 =?us-ascii?Q?NfrdH5P1Q93DAKju7icuNg9QCdcSxAyfeVKrOs2qK8BA0ZetlkBw5nU5RODq?=
 =?us-ascii?Q?SN8x9T46e4hcPkZ++IWH4bPMP9c8ItjppquER5Fc6uBQXg2m1Dlp5wSpOH6P?=
 =?us-ascii?Q?1yiFLsbM0kSPliziCTAXbVynxUdwF5pbC380JDG5ojDus6JW6AI5dxMm7/iy?=
 =?us-ascii?Q?oW/DyQAmnsHK7m9GxzUlsGGcQkE7yXD7ejDLU0rvHdE6oukyzeQFZXM3no6O?=
 =?us-ascii?Q?9fHkKg4EzPxbIPdk7LWTGWzJ2XiqR2SGLul2JCWcb1HjGu2YrhEt06XgjrlF?=
 =?us-ascii?Q?wZeSa/qonvTkQTiTUtV8DQvqGSNGzBGF16N/u60F1bjMM2UTPO8d1wLxU5ob?=
 =?us-ascii?Q?Vn8aTz/0w6i48JW+afnTTXQpKvvJHgDCW8DuF25MScNJhKiE/9D3fDs20yoi?=
 =?us-ascii?Q?uqbGixDTVIwmQjX/Z8dnktFQ2RjX4zAbLCi4ogzla1Uz+5Ul0p3LJiEEnDjj?=
 =?us-ascii?Q?yaFfOPuiSkbqODu5/rZurZ4aBOgdmdfjsOcl4p/KDoTIMn7+BsCYqtI3iVTl?=
 =?us-ascii?Q?4mnQlGaadqZU9H2YUzgGEMt1x1BZ3OBGoHLbJlM6gu1Uw4C4xCOsRlOOPEHw?=
 =?us-ascii?Q?aXBSyHgHPpkkrVds5RIgt9d2OoWOvzoFyH9mgGADB0g9RgpPPXKx7k0/FV0b?=
 =?us-ascii?Q?M/EiEOID40rQImlLSlMRJCjsdDMvpPjUqSLA4q6?=
X-Microsoft-Antispam-Message-Info: 3nO9V7clLpBv62cgwnxqK+nGr8l2ZvJN4YWzWF5WlONAGRXJRXEAx7sUeJVQzEnjlXD/GU2TuKYWjkeaKqtfT/IrxIvR8GA94VyRaT1F9LgOhYKE+U7Bbz/6+T1Vl3QwpuJmBvAYyL6rKk82gP7RLkVktXw4TlPsbme4bghgM8HfxkFbCG8QbLC4ahzEB7Cy
X-Microsoft-Exchange-Diagnostics: 1;CY1PR12MB0327;6:O6GnhDJXq0MnDdWM6QHn6BJ0rfdi6BrQBJ3G0ZA6cly+S3NRZjBeqLULBvmOW1ox6DQKDn4U9ssZFDyHgDJGzk/SSSYRSFLhzO8eDtyrXQN5aGQXHoxjeHUzUhELo3vzEs/u02XENomnOvp+TP6E5vOsH/mM6gE3MEiz4402ppzd6uB7AmlYCHs11zhP8lmCFZKMmmCFsgxGxwiHlr65kcfpHL6higvetkFiILllcr+SGHH5ipyQojuGlsiZbTAgT2nuHrQp3QernUPtCMDs6aY9vY62Q/eKqi/nxHGyORBMACFNo9pVR/NfWE4bR4CNnixt4o70JHROfzXglgR9HStpWcSk29673hpTMWleVK9rCYrA42fPnmm654OHCDr3Nhkp05Umw9xcrtPYF6mNXOwPsVG4Z09Eh16PMe431g7f9Nj8A7/UmRIDZRM7GtFIJwdenO8cOlfbb3ElPypxTg==;5:YGfTNckQi/xZ6RJckU27yf7HgbwW5pvZhoyZ0ciu+yHeog0olepC4al8T0wNF44NantdU6bm24N82+Mr6BeEsXdX2wSYoMqtPSAMa/AQDgc1BuuKZTcd3wM3rJF1RZrPHVMt/ExafwOsR/E3B7eAXsrKONnpIOWwZRmNCo5GcgY=;24:oTCi2S2zBzwGOh+qVioBGQXMZY7ric54RZznX3SMmT4UP4pTuKJBV8zovBHRdhGlHM1qm5wlvOxWnSZl6s2nisjN6HQy4+I16FnEguIkOzQ=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY1PR12MB0327;7:gtTWXlYgQ2cR9b9Lh5KlDvzhR1QT76hEKyzaEirsFGt4qEjNTnU6rf1/xKYoGhL/Vdjg4zZyLUoczvLZqWOahW2fDkQ9NswCRLl09/BU1xE2ySPotoSKWQYatFB+1nLZzMtfarsU/6rIseRUcJ8h8JgekKrMjQZc0PmPw6xNZaQjFy2YkEwm1+T0PjrYt0CK+iuesnrTZF5SHekNYlwFasiRq43dtss4Hoc+VvLiPC3Mo5Lb8CALP8495x033wJx;20:Ho7Vl+CYbf19+mXGxiwpbMwbXPpDjJTMl6yr7F9ZUxNKNLYNyOhU2opB+JhfnKzcxKQoHZ5jUn9m7RJW/lYI80eLOovGb4a3CPb71zAv9f7radJwYRUqs/AheGjyVoHyXcUbtlwdhanzIAp8tqRIeVWj/RzeLBKOL6hAJYX08wMOrGNoZUyRJcIeMacnS04T9sh3wmvsT+pGEo/DzuH7yBX0oF360ucx0Qz9lyVTKRz+4UECMOR7pb0guLX++7m/
X-MS-Office365-Filtering-Correlation-Id: 7682eb23-46da-47da-27cd-08d5afa4f01f
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2018 20:48:47.5395
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7682eb23-46da-47da-27cd-08d5afa4f01f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXCHOV02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB0327
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599296222297617705?=
X-GMAIL-MSGID: =?utf-8?q?1599296222297617705?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Removed separate byte count variables for playback and capture.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Reviewed-by: Daniel Kurtz <djkurtz@chromium.org>
---
v1->v2: Fixed review comment in acp_dma_pointer callback
 sound/soc/amd/acp-pcm-dma.c | 19 +++++--------------
 sound/soc/amd/acp.h         |  3 +--
 2 files changed, 6 insertions(+), 16 deletions(-)

diff --git a/sound/soc/amd/acp-pcm-dma.c b/sound/soc/amd/acp-pcm-dma.c
index 6e338fe..862c1cf 100644
--- a/sound/soc/amd/acp-pcm-dma.c
+++ b/sound/soc/amd/acp-pcm-dma.c
@@ -866,13 +866,8 @@ static snd_pcm_uframes_t acp_dma_pointer(struct snd_pcm_substream *substream)
 	buffersize = frames_to_bytes(runtime, runtime->buffer_size);
 	bytescount = acp_get_byte_count(rtd);
 
-	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
-		if (bytescount > rtd->i2ssp_renderbytescount)
-			bytescount = bytescount - rtd->i2ssp_renderbytescount;
-	} else {
-		if (bytescount > rtd->i2ssp_capturebytescount)
-			bytescount = bytescount - rtd->i2ssp_capturebytescount;
-	}
+	if (bytescount > rtd->bytescount)
+		bytescount -= rtd->bytescount;
 	pos = do_div(bytescount, buffersize);
 	return bytes_to_frames(runtime, pos);
 }
@@ -921,9 +916,9 @@ static int acp_dma_trigger(struct snd_pcm_substream *substream, int cmd)
 	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
 	case SNDRV_PCM_TRIGGER_RESUME:
 		bytescount = acp_get_byte_count(rtd);
+		if (rtd->bytescount == 0)
+			rtd->bytescount = bytescount;
 		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
-			if (rtd->i2ssp_renderbytescount == 0)
-				rtd->i2ssp_renderbytescount = bytescount;
 			acp_dma_start(rtd->acp_mmio, rtd->ch1, false);
 			while (acp_reg_read(rtd->acp_mmio, mmACP_DMA_CH_STS) &
 				BIT(rtd->ch1)) {
@@ -934,9 +929,6 @@ static int acp_dma_trigger(struct snd_pcm_substream *substream, int cmd)
 				}
 				cpu_relax();
 			}
-		} else {
-			if (rtd->i2ssp_capturebytescount == 0)
-				rtd->i2ssp_capturebytescount = bytescount;
 		}
 		acp_dma_start(rtd->acp_mmio, rtd->ch2, true);
 		ret = 0;
@@ -955,12 +947,11 @@ static int acp_dma_trigger(struct snd_pcm_substream *substream, int cmd)
 		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
 			acp_dma_stop(rtd->acp_mmio, rtd->ch1);
 			ret =  acp_dma_stop(rtd->acp_mmio, rtd->ch2);
-			rtd->i2ssp_renderbytescount = 0;
 		} else {
 			acp_dma_stop(rtd->acp_mmio, rtd->ch2);
 			ret = acp_dma_stop(rtd->acp_mmio, rtd->ch1);
-			rtd->i2ssp_capturebytescount = 0;
 		}
+		rtd->bytescount = 0;
 		break;
 	default:
 		ret = -EINVAL;
diff --git a/sound/soc/amd/acp.h b/sound/soc/amd/acp.h
index 3b076c6..82470bc 100644
--- a/sound/soc/amd/acp.h
+++ b/sound/soc/amd/acp.h
@@ -93,8 +93,7 @@ struct audio_substream_data {
 	u32 byte_cnt_high_reg_offset;
 	u32 byte_cnt_low_reg_offset;
 	uint64_t size;
-	u64 i2ssp_renderbytescount;
-	u64 i2ssp_capturebytescount;
+	u64 bytescount;
 	void __iomem *acp_mmio;
 };
 
-- 
2.7.4
