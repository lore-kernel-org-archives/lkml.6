Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224xM5heLDNqKDcedTEH3exKPkEqO+ea71LD89ixcEXULkKTMsT42ZGW1DR+E0QkvaC+xv1k
ARC-Seal: i=1; a=rsa-sha256; t=1519676613; cv=none;
        d=google.com; s=arc-20160816;
        b=Gt4U2zmKwfp8usi3y+R2sg8ehDAeLjQELp/59LzrOE/OR5vO0jMSc3S3H9mNt2Rlk0
         FBDyQfIfk73Eq2rGqO2M9aTXsej0nFOC8cahHz2GFQX44/jf6RS3QM9f+R7LjIK6x2hW
         1xEqGxoxAh1+mGNNuRxlVu6j4su+VjH/aCT2Rz9D16blBiOyuNBZKY8hbtO0loe77Mra
         7tXu0RSHcQp3u4SC1g9daZlrY9MyfxjXh1pJWzHDs2J+Zu0qXRlVOrrlyRbUCT6VNlTl
         hgGENP0PiHsyS+4Id/zxIXYDo5HVWIOufHhbCObPXWIa3Xay4qEKmS5zTGnEVk/cWWcZ
         Jc3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=P7QHFSssHPxeqVi52deINguJ0YTjCj/45elannTq5Ow=;
        b=SglGZVZgnkBHrYETwG+nM1sVO7x8Lqqr72gLDUulZt8axwVH1/Mj3S0eOwHYGAd2SB
         EmcWFPm2MKNwuPgKC2BQI64ayyEsVe7xMCE+cZWyTlguRIcd8noh0NleE/NcYGaonu+A
         Dz3rF5WRNgrJduBndr0vUyUOAdjj53gv8BMwsATJPAaKETQMFaRb0kIHcPw9l2fdyjUv
         K8Sp5w1ukTe+de4eV0+ZivDSuTdHGe6/lJgDvwVVsh1beMNmZvsucq95c05rZC2Fou2s
         3XDVVKv2DZ8E7Pi+CNISxGZ0gieoaPAxWg+UFUXElQ78d+5tJ1H9f0zC63DaJYTmEqxW
         LmJQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Hans de Goede <hdegoede@redhat.com>,
	Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCH 4.14 15/54] extcon: int3496: process id-pin first so that we start with the right status
Date: Mon, 26 Feb 2018 21:21:52 +0100
Message-Id: <20180226202145.139357900@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180226202144.375869933@linuxfoundation.org>
References: <20180226202144.375869933@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593496425033407350?=
X-GMAIL-MSGID: =?utf-8?q?1593496425033407350?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hans de Goede <hdegoede@redhat.com>

commit 0434352d3d2e950cf5e743f6062abd87de22f960 upstream.

Some other drivers may be waiting for our extcon to show-up, exiting their
probe methods with -EPROBE_DEFER until we show up.

These drivers will typically get the cable state directly after getting
the extcon, this commit changes the int3496 code to wait for the initial
processing of the id-pin to complete before exiting probe() with 0, which
will cause devices waiting on the defered probe to get reprobed.

This fixes a race where the initial work might still be running while other
drivers were already calling extcon_get_state().

Fixes: 2f556bdb9f2e ("extcon: int3496: Add Intel INT3496 ACPI ... driver")
Cc: stable@vger.kernel.org
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/extcon/extcon-intel-int3496.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/extcon/extcon-intel-int3496.c
+++ b/drivers/extcon/extcon-intel-int3496.c
@@ -153,8 +153,9 @@ static int int3496_probe(struct platform
 		return ret;
 	}
 
-	/* queue initial processing of id-pin */
+	/* process id-pin so that we start with the right status */
 	queue_delayed_work(system_wq, &data->work, 0);
+	flush_delayed_work(&data->work);
 
 	platform_set_drvdata(pdev, data);
 
