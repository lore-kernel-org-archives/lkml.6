Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49EBlokm0EKh2jYZE6XGKEGIwqgKgAEgG6IIfyt1WW+iQjDPyEq39l2MqAkJO3P6Jy85kAs
ARC-Seal: i=1; a=rsa-sha256; t=1523472579; cv=none;
        d=google.com; s=arc-20160816;
        b=qbi+c0HtWMTipZcS+xFMjS0j4XGpd3YHRrlJKciEVRv7eB4Sd+aHC6hH10t8kxLlxi
         uSNdNxb7PHPJLDJNdMtFx0GEEyBKtgkgqC2LaOF6l8JukSRjdC/+UC9zrKnHhGaQCVMH
         L0CvuOrzI5E0TFSmVqbUEplMal6HvkEh3qD4p6gEqzRNm9mJzPD6+4SxmKa1+aKIEW85
         FupPVGJ1l8+dea8nALyzwA3tS+AD9nZa2vIQjy0H1fgUv482vvUTG2TY4BmS5mL+A35O
         hQXK/3nWLeIHq6TgvN2TuxWOMu7Gk3QXy8vGlo3DmRZnZ26Pl7mr0ukplZQ6hOBvdzbg
         wtqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=y9jXHNe+IqiepnDzt5bbHgHm/as0nQ1wv4jlfFgfClM=;
        b=ehPM26UvpglJrAow4VU2aE7sQDA69Z65Qxq4kSmrLkafCAaHpySF7xCiV2GBrxDwNa
         JK6Yv69jjzUnEX8/BLFw1sGyBvJqD84Lw1NO2qr7/eLPT4rJhdAGNKfcv6H6GtRH2yh5
         6/dNhAXJhUiZub9ySqVi4i8MchsZ4dC+InZz/lqNmDhFZtWiX4QR+eGEhWygVMiQQYvV
         ld2VarxAPe/hiOyP+TG3vl9UfQPNbzmxD9muPd1xYzneut8RyIB8/qaq074o1i45cPtj
         Cg+LCxs5fWgp50KARIUiNcirHClACUvRqpL9zko7fHqoVHudbSQn8tdUWRFwP+HuebZR
         WXfA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Vaibhav Jain <vaibhav@linux.vnet.ibm.com>,
	Steve Best <sbest@redhat.com>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 102/190] rtc: opal: Handle disabled TPO in opal_get_tpo_time()
Date: Wed, 11 Apr 2018 20:35:48 +0200
Message-Id: <20180411183556.536661881@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183550.114495991@linuxfoundation.org>
References: <20180411183550.114495991@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597476783800183911?=
X-GMAIL-MSGID: =?utf-8?q?1597476783800183911?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>


[ Upstream commit 6dc1cf6f932bb0ea4d8f5e913a0a401ecacd2f03 ]

On PowerNV platform when Timed-Power-On(TPO) is disabled, read of
stored TPO yields value with all date components set to '0' inside
opal_get_tpo_time(). The function opal_to_tm() then converts it to an
offset from year 1900 yielding alarm-time == "1900-00-01
00:00:00". This causes problems with __rtc_read_alarm() that
expecting an offset from "1970-00-01 00:00:00" and returned alarm-time
results in a -ve value for time64_t. Which ultimately results in this
error reported in kernel logs with a seemingly garbage value:

"rtc rtc0: invalid alarm value: -2-1--1041528741
2005511117:71582844:32"

We fix this by explicitly handling the case of all alarm date-time
components being '0' inside opal_get_tpo_time() and returning -ENOENT
in such a case. This signals generic rtc that no alarm is set and it
bails out from the alarm initialization flow without reporting the
above error.

Signed-off-by: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
Reported-by: Steve Best <sbest@redhat.com>
Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/rtc/rtc-opal.c |   10 ++++++++++
 1 file changed, 10 insertions(+)

--- a/drivers/rtc/rtc-opal.c
+++ b/drivers/rtc/rtc-opal.c
@@ -150,6 +150,16 @@ static int opal_get_tpo_time(struct devi
 
 	y_m_d = be32_to_cpu(__y_m_d);
 	h_m_s_ms = ((u64)be32_to_cpu(__h_m) << 32);
+
+	/* check if no alarm is set */
+	if (y_m_d == 0 && h_m_s_ms == 0) {
+		pr_debug("No alarm is set\n");
+		rc = -ENOENT;
+		goto exit;
+	} else {
+		pr_debug("Alarm set to %x %llx\n", y_m_d, h_m_s_ms);
+	}
+
 	opal_to_tm(y_m_d, h_m_s_ms, &alarm->time);
 
 exit:
