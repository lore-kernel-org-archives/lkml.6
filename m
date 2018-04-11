Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx491FYk+pF4MRjBXBr4B35fXUt1qSrjdQJr/rr/QY7DDXifzfSnGW+/dyggAcKICL03AV7Ld
ARC-Seal: i=1; a=rsa-sha256; t=1523473389; cv=none;
        d=google.com; s=arc-20160816;
        b=02xIUcwG7ufqS9Sy2CCWFj79+AYn/UCfT6Gi7TCrUVr572LZV2LeqKYpDOw4/SMcK1
         UnPMS7ky+l5j4lMuBKMNXUBroDSV+scCtmbykY1Y4aGH/ks2VVozXfziT3aZA5mM5YcC
         sZ3vGJ/7tUhqU6B65XKVUG7YijUqFZeJKl9/JWtcAtJ6nhpuxKFU34C+HIrXk4BuSMWT
         481y2MiWL3JnDqhhT0X9X9+Jf02Bb1kUAJZsvgiCyx8x1+FLQrEkAqLA9+9RJt3ufhQP
         3G1Aq5/EmML9MwUvKhfgdtif53aR2iqSGAEhIoXWkX3Gs2kmRLbGZqpVQu0AasAfZ4k7
         bHHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=62hqTOe5x8sZvMeWHP+vUE5YhqV6MXijX2cGx5paJj0=;
        b=Gpc/+qaAyt3FZmSSCcK8h9IQgIM46JiwNYDdXmlqfgVrkl4uzoWU2kXfces0wl+6kS
         PAsxYd3ZaDj9vht6/M69S7SB+9a4S7hOMblMNPvVA8Bc+X+LTlVZwzYc2JVpVAIixNpT
         ViM8Bvkd7Sa1SPlCTho3hx5d9HlIzNMyzT7hf5lt9ovB7ZnQiaQhFmPm2WXGVPoHBq81
         fzfGsG+R3lC6wLpRB5cIhfTvwcCT725sWkEHR+7InTSU8OrLj/IczEvptMa7uu8qGrkH
         +z7BNuvzFoV/0y1BmPh4V5MLCvnmpnx1/WrQ8L6Ykpo1epuhvVnkdX62vqx1aHL30o7Z
         An/w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Robert Walker <robert.walker@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 230/310] coresight: Fix reference count for software sources
Date: Wed, 11 Apr 2018 20:36:09 +0200
Message-Id: <20180411183632.403871237@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183622.305902791@linuxfoundation.org>
References: <20180411183622.305902791@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597477632969747026?=
X-GMAIL-MSGID: =?utf-8?q?1597477632969747026?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Suzuki K Poulose <suzuki.poulose@arm.com>


[ Upstream commit 022aa1a81b778789ee7cf3124595854276a0330d ]

For software sources (i.e STM), there could be multiple agents
generating the trace data, unlike the ETMs. So we need to
properly do the accounting for the active number of users
to disable the device when the last user goes away. Right
now, the reference counting is broken for sources as we skip
the actions when we detect that the source is enabled.

This patch fixes the problem by adding the refcounting for
software sources, even when they are enabled.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Reported-by: Robert Walker <robert.walker@arm.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/hwtracing/coresight/coresight.c |   15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

--- a/drivers/hwtracing/coresight/coresight.c
+++ b/drivers/hwtracing/coresight/coresight.c
@@ -498,6 +498,9 @@ int coresight_enable(struct coresight_de
 {
 	int cpu, ret = 0;
 	struct list_head *path;
+	enum coresight_dev_subtype_source subtype;
+
+	subtype = csdev->subtype.source_subtype;
 
 	mutex_lock(&coresight_mutex);
 
@@ -505,8 +508,16 @@ int coresight_enable(struct coresight_de
 	if (ret)
 		goto out;
 
-	if (csdev->enable)
+	if (csdev->enable) {
+		/*
+		 * There could be multiple applications driving the software
+		 * source. So keep the refcount for each such user when the
+		 * source is already enabled.
+		 */
+		if (subtype == CORESIGHT_DEV_SUBTYPE_SOURCE_SOFTWARE)
+			atomic_inc(csdev->refcnt);
 		goto out;
+	}
 
 	path = coresight_build_path(csdev);
 	if (IS_ERR(path)) {
@@ -523,7 +534,7 @@ int coresight_enable(struct coresight_de
 	if (ret)
 		goto err_source;
 
-	switch (csdev->subtype.source_subtype) {
+	switch (subtype) {
 	case CORESIGHT_DEV_SUBTYPE_SOURCE_PROC:
 		/*
 		 * When working from sysFS it is important to keep track
