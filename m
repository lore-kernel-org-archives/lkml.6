Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx494rT9M0J04m9zlz/bxyDI5ik9Ck4b9/56hGo1koSd1eLEGCWX7yOxX4vVAgLgTBl+8lgR9
ARC-Seal: i=1; a=rsa-sha256; t=1523473458; cv=none;
        d=google.com; s=arc-20160816;
        b=LiSgcsvjUGJL3e8qLlYseqAEJZBE7QH7XWQo1pq0rmq6Cf9LMdc6poSel8VQd7PV2X
         FERcrUnBA4gFWq9Ga42yxQagNYiQxBSCmv0beBi0DfrlObNzeV7Cf1V0jiN+31pwoJOk
         6QAOw0/X4nplDNozEnP1ZKlfjH2oJDPElNwub8GXvMSRAFEGZKI1Xcjc34UgQV5a5ami
         RHlHJc2HlBllnRw1gm/8MEWRxGzqQAlwGHAw7VNicNFAiOm5Ce3MTWxVByrb2zJFFsHc
         U+eBIm0XGDkvOUbAtNpPEyFQCRI8lrZT96asvjRweAjSS9ml3Npcoye6SjGiXri3dBad
         erLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=YuupGo5JzcZMPgtwTjWAx1zHkTHZqGSnnkyBqVLtUqA=;
        b=wKwuhX2Xm8ERAyli+V3tNTHuCXD/e1RUzWqrYRf2fZ66N0wU9knT6p71yFwHEFxNbf
         dUuZIeg3c0L4lIU4Qxl4GskF05Adn/X/W3YPIXwBS1k1OgDThNq+IEtUFCjfybST0XIY
         scGU3tkLRE2/4mXnlJ5CvbVZ2b2cFODFHCRoZsKxfSP6P/36k8yjiYkL0U4BbfMGUy1n
         zi7m39ONaXN5feCc296BIxFgC8+ziSfZHxiO4fY1j/7Vc07wiHq5U+MXFtjHiCeQNf7l
         +EQ8kE9Oj75BJC5CsIx7wjVMJtW1Ofc/kG1SrCAef/xVwFTRNndbYBqWiCXbdKoDchCL
         n+vQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Christophe Jaillet <christophe.jaillet@wanadoo.fr>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 248/310] cpuidle: dt: Add missing of_node_put()
Date: Wed, 11 Apr 2018 20:36:27 +0200
Message-Id: <20180411183633.120778550@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183622.305902791@linuxfoundation.org>
References: <20180411183622.305902791@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597476804151066112?=
X-GMAIL-MSGID: =?utf-8?q?1597477705495549463?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Christophe Jaillet <christophe.jaillet@wanadoo.fr>


[ Upstream commit b2cdd8e1b54849477a32d820acc2e87828a38f3d ]

'of_node_put()' should be called on pointer returned by
'of_parse_phandle()' when done. In this function this is done in all path
except this 'continue', so add it.

Fixes: 97735da074fd (drivers: cpuidle: Add status property to ARM idle states)
Signed-off-by: Christophe Jaillet <christophe.jaillet@wanadoo.fr>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/cpuidle/dt_idle_states.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/cpuidle/dt_idle_states.c
+++ b/drivers/cpuidle/dt_idle_states.c
@@ -174,8 +174,10 @@ int dt_init_idle_driver(struct cpuidle_d
 		if (!state_node)
 			break;
 
-		if (!of_device_is_available(state_node))
+		if (!of_device_is_available(state_node)) {
+			of_node_put(state_node);
 			continue;
+		}
 
 		if (!idle_state_valid(state_node, i, cpumask)) {
 			pr_warn("%s idle state not valid, bailing out\n",
