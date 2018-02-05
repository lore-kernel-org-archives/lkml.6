Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224nl9GZ8ji8Cv5db3emTODayxDQbV86tNl7R1ctaMP4sqKcjfxxVKPvAA6H+Zski9r2Jgvk
ARC-Seal: i=1; a=rsa-sha256; t=1517855052; cv=none;
        d=google.com; s=arc-20160816;
        b=NBj2YfphU2tbs4uPhApMe2XkGZoDAm+ZDa38uWoZyNpdHTVopOxEz7+OwTnevFMUq0
         ERRenZ7pf3AzKTMjfrJw3dczjuNOjQXOSsPu+qMN36KEJe/buQ5qjREOnu+Qo15o5mKW
         fOTT0f8MRaRY2E8gUWMfs0w+Ck5wERcJFth5JbuXvVNJLoR3s0jJm0F3KdsuE/2s2aUs
         pLQAxSXJH5846gZz30wPx9Me4DFhVrw2M/FwQS8px1NtjqnkPHSfzj4EcBYwUIlXmTSE
         SV3lBFtSMaeo9yLj6Lc775ZllwGqzdmHyTa/sx0J1zNOesEWTNpapaALzTzBcuJ7e90x
         vMtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=ruk9+QVCRddjEDzWgQfUSw78CE1pyWzD/qBWatdmJoE=;
        b=wS1A/yzj3hoMWUmmeBcV3yU6B0ecEpWYtlMAkBc4eha1YTFGfv9SaOeh2wkoO2h2c/
         zJRrPsjAf5jtJVERrdnGYxmOT5PNixTrMKWPyIz2ZaRQm8vXXF2Vk43T45uyf389dIIc
         IUk9MgPKR03YKFT3E0YQW/cRtmieUzeJGLYrzEyim5bMe8kzgmIkzzCFpP4ZMIn6hYsk
         QyBtWfMqfNHdBEPJSnZZCrPDV3fER5ndppEme/0RptbywVeSQE7krXLS4CMzEpRqcdfW
         pLC2Rrg17JqgyVujLZUgAzgFBuhVRXqjTsXDuFRa3OZfSYhtCDFojfnbAAoPCjDnCYK3
         8PIA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 104.132.1.108 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 104.132.1.108 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Liu Changcheng <changcheng.liu@intel.com>,
	Richard Weinberger <richard.weinberger@gmail.com>,
	Richard Weinberger <richard@nod.at>,
	Thomas Gleixner <tglx@linutronix.de>,
	Philippe Ombredanne <pombredanne@nexb.com>,
	NeilBrown <neilb@suse.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.14 01/64] scripts/faddr2line: fix CROSS_COMPILE unset error
Date: Mon,  5 Feb 2018 10:22:20 -0800
Message-Id: <20180205182138.629053172@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180205182138.571333346@linuxfoundation.org>
References: <20180205182138.571333346@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591586379631897095?=
X-GMAIL-MSGID: =?utf-8?q?1591586379631897095?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Liu, Changcheng <changcheng.liu@intel.com>

commit 4cc90b4cc3d4955f79eae4f7f9d64e67e17b468e upstream.

faddr2line hit var unbound error when CROSS_COMPILE isn't set since
nounset option is set in bash script.

Link: http://lkml.kernel.org/r/20171206013022.GA83929@sofia
Fixes: 95a879825419 ("scripts/faddr2line: extend usage on generic arch")
Signed-off-by: Liu Changcheng <changcheng.liu@intel.com>
Reported-by: Richard Weinberger <richard.weinberger@gmail.com>
Reviewed-by: Richard Weinberger <richard@nod.at>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Philippe Ombredanne <pombredanne@nexb.com>
Cc: NeilBrown <neilb@suse.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 scripts/faddr2line |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/scripts/faddr2line
+++ b/scripts/faddr2line
@@ -44,10 +44,10 @@
 set -o errexit
 set -o nounset
 
-READELF="${CROSS_COMPILE}readelf"
-ADDR2LINE="${CROSS_COMPILE}addr2line"
-SIZE="${CROSS_COMPILE}size"
-NM="${CROSS_COMPILE}nm"
+READELF="${CROSS_COMPILE:-}readelf"
+ADDR2LINE="${CROSS_COMPILE:-}addr2line"
+SIZE="${CROSS_COMPILE:-}size"
+NM="${CROSS_COMPILE:-}nm"
 
 command -v awk >/dev/null 2>&1 || die "awk isn't installed"
 command -v ${READELF} >/dev/null 2>&1 || die "readelf isn't installed"
