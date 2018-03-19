Return-Path: <mika.westerberg@linux.intel.com>
X-Google-Smtp-Source: AG47ELs8rFiOk9h5dk+a+vgSIOpJvU95yfJtRN8RougAdlp+bULFZaGfGpAo4rjmGy4eDyjGOA7W
ARC-Seal: i=1; a=rsa-sha256; t=1521476832; cv=none;
        d=google.com; s=arc-20160816;
        b=IVCZs5j1108NtHt0BwLMa38iHA4veuJTxLT+KRUzlJo8ad6snqLaUT6LhXtY/vSyob
         c1lFhUudlZ4VHu2gGLGfCVnRckGLscPQQOny63f83XPxtKdMJWr9l5BUWDA4SsKRI7yW
         DiA5DP0DRezgB0lWn4eKP6QiL5wT1XxXMoOWncI147Gtf4wRInC0JeD8w/ATeQ4+2SPK
         iWr6HEYw7I+JB3c1KayAxNtlNml6juprG1gzVbMUX1Y38c6NkH0brJu05TzzELhW63bq
         QAoaQDPiu6IsJFRh89TCMON4irYjlZBkeSRV2SdTNDbcqBtlrR0EOWcXdTmeEBlJ56zz
         fqLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=dn8DJ2X8XkQe1lTViakLiRrfuIBGG1A2H5xfSS9SlxQ=;
        b=GByyteBegmpAsaezczoZu0NNkWn9KmjFvorPRTli30BpioLnyIa3yXjh7nzXLaUQne
         HnH1MgCc1UbNpKfdx6di1eE/Vs+yzneYYH6JgIMsR5ukW2loL9RYHA/VpUQQ0iKToZbK
         YOo1LAtcZbCX+JJif+9kC+GMFzEXOb/c+XHtbqDumkCu6AqLwSU8IB3bEwBIYa8ucS6h
         6GuwJI4P2EI/5gN08zA05lbCjyvmCwGoj5aBPjFOUzJdqF/RLeTqy2hi0V1HQtuAzY0h
         LXCfnYMsxbgwfxBSa3fmUrEmg9O6gFpj9IFkvM/+uVB24SbnTjbAoFAnV9wO6G1j08Z7
         Nvwg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of mika.westerberg@linux.intel.com designates 192.55.52.115 as permitted sender) smtp.mailfrom=mika.westerberg@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of mika.westerberg@linux.intel.com designates 192.55.52.115 as permitted sender) smtp.mailfrom=mika.westerberg@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,331,1517904000";
   d="scan'208";a="26991270"
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Andreas Noever <andreas.noever@gmail.com>,
	Michael Jamet <michael.jamet@intel.com>,
	Yehezkel Bernat <yehezkel.bernat@intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 10/19] thunderbolt: Add tb_switch_get()
Date: Mon, 19 Mar 2018 19:26:54 +0300
Message-Id: <20180319162703.5331-11-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319162703.5331-1-mika.westerberg@linux.intel.com>
References: <20180319162703.5331-1-mika.westerberg@linux.intel.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595384090780638066?=
X-GMAIL-MSGID: =?utf-8?q?1595384090780638066?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Sometimes there is need for increasing reference count of a switch as
well. This also follows what we have for xdomains.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 drivers/thunderbolt/tb.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/thunderbolt/tb.h b/drivers/thunderbolt/tb.h
index 895c57a0a090..c7bd77e9c2c3 100644
--- a/drivers/thunderbolt/tb.h
+++ b/drivers/thunderbolt/tb.h
@@ -387,6 +387,13 @@ struct tb_switch *tb_switch_find_by_link_depth(struct tb *tb, u8 link,
 					       u8 depth);
 struct tb_switch *tb_switch_find_by_uuid(struct tb *tb, const uuid_t *uuid);
 
+static inline struct tb_switch *tb_switch_get(struct tb_switch *sw)
+{
+	if (sw)
+		get_device(&sw->dev);
+	return sw;
+}
+
 static inline void tb_switch_put(struct tb_switch *sw)
 {
 	put_device(&sw->dev);
-- 
2.16.2
