Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx493rzVz9fTH37+SxNH6pLuzUOrB7uN9vC70jqKfvBro20IFnrGs3xYQ7ofEc6zb1Z2v1fQW
ARC-Seal: i=1; a=rsa-sha256; t=1522168511; cv=none;
        d=google.com; s=arc-20160816;
        b=P5e+no+RhUbAkDJNP25mfyWWBCaevGrBMJ9tZbBd27AnRfNuFBmvtqycflhb3wWrb3
         dlt+uvC+1AslZrGTRJ65kqhXyl4kqYcktTtIje6Tl00KDvCDcJVar7ZoZmhFRkH504wM
         n0YySs0BcF8BHNMdmMlH3e9Mo/7OS1UltGtiMXpbgqGoDHzfG8pr892O3TFgKa2yGFBW
         TDfVGbm+XmhrwTOBsp3OlxtNLwFaTS9tct72SlDmHtNRMp88Zh73jglGq4LpzFENOZGB
         c8sLm83kAAQB4R6qTHuUklWDjTqx/n0XQzYf1z2+gYjShET4fd206rvdYNItn8qdLf4v
         rFxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=+fGk7r/z4kkJ0n3+Or9WagpgxeqCPZcwWalhOzJ5wQM=;
        b=uf0SBSMJDXEck/6wFfv0vDhszGh566q6bZfEAImnbusFSqYpMSP9youXqrIIx5XzDs
         Dz2E+Jin/DP1Kc0nTYisN/c726iMD7CQN1iz7RznG0HJN8JoskhsU8lIESVPAS6Bs6uX
         kfzaVXEbSAWgc7G1AETn4AkPuK13DrQApc/On4mVpWrYiMUqQiGURv3IKr8dGSrS5+XG
         IDHw7KO+y+hXaVichD1yRbEdCb6w4H1Q/YJK690QSv4DVxrfpRIAgYJn2HMniqtGWSOg
         JIFtan4lFLHR/i9vIfcCitLhpqVlaCPFQjPanXBefh3PDJAB52gi2h2/ciURRPyZtQja
         W7Og==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Hans de Goede <hdegoede@redhat.com>,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 4.14 037/101] libata: Apply NOLPM quirk to Crucial MX100 512GB SSDs
Date: Tue, 27 Mar 2018 18:27:09 +0200
Message-Id: <20180327162752.288325636@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162749.993880276@linuxfoundation.org>
References: <20180327162749.993880276@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596109050829353966?=
X-GMAIL-MSGID: =?utf-8?q?1596109369416724224?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hans de Goede <hdegoede@redhat.com>

commit 9c7be59fc519af9081c46c48f06f2b8fadf55ad8 upstream.

Various people have reported the Crucial MX100 512GB model not working
with LPM set to min_power. I've now received a report that it also does
not work with the new med_power_with_dipm level.

It does work with medium_power, but that has no measurable power-savings
and given the amount of people being bitten by the other levels not
working, this commit just disables LPM altogether.

Note all reporters of this have either the 512GB model (max capacity), or
are not specifying their SSD's size. So for now this quirk assumes this is
a problem with the 512GB model only.

Buglink: https://bugzilla.kernel.org/show_bug.cgi?id=89261
Buglink: https://github.com/linrunner/TLP/issues/84
Cc: stable@vger.kernel.org
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/ata/libata-core.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -4520,6 +4520,11 @@ static const struct ata_blacklist_entry
 	{ "PIONEER DVD-RW  DVR-212D",	NULL,	ATA_HORKAGE_NOSETXFER },
 	{ "PIONEER DVD-RW  DVR-216D",	NULL,	ATA_HORKAGE_NOSETXFER },
 
+	/* The 512GB version of the MX100 has both queued TRIM and LPM issues */
+	{ "Crucial_CT512MX100*",	NULL,	ATA_HORKAGE_NO_NCQ_TRIM |
+						ATA_HORKAGE_ZERO_AFTER_TRIM |
+						ATA_HORKAGE_NOLPM, },
+
 	/* devices that don't properly handle queued TRIM commands */
 	{ "Micron_M500_*",		NULL,	ATA_HORKAGE_NO_NCQ_TRIM |
 						ATA_HORKAGE_ZERO_AFTER_TRIM, },
