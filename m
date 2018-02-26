Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtxeM1BQNP2ALGOM/tdc3Zh1SvH5l041RBRha0cSPeuNWY1q3JF6iSzxM61oQP4226O/wdd
ARC-Seal: i=1; a=rsa-sha256; t=1519676785; cv=none;
        d=google.com; s=arc-20160816;
        b=s5xw9kewKPLZ8VdEWB54xLvrHqNQoW9tCR1RYKExsKkzHPdzjl8xjEAHLcRKFqK27a
         hC5+hn9Gffr4yMQ03hTMgQN80L/GJKi/b5701EEULDbDkJYBjfcBwxyVLdJOTHNM+par
         0gPjrwlhA82C0F7aRjZh1zxKhMbv+ogBbHNAWCgcKKh8yOxwFMTL7pTuz6KntNdAPCOu
         GKi6wRDLjU4Fmi8vulZvMYFzL8MioQtj6jrgl1uzVZ/dT507vvdaWZKuNxAccm5FiA8d
         ywKQS+uf5160FCqxLmbfEHtpUXXvxaglDOSiLUVrIawnQmWT+a1MnYBC0a/TkASw57sZ
         TIKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=cESx/j5BudWOrRzNudP8uilrcUPrHpJLcIaFHOiW1nQ=;
        b=ZTjHnJH/GkdNggVz1F91Mt+6d+/z+zGTg4eZsNpuDQ3FtrtYqmLcL4zw2KWbIzUk9r
         NHcgOBxLglcrupX/5RyxUdjXdo8lY4dObuN+ZN5FZ8oLOQzEhQAy7BAZyjO6/9+3z2A/
         Z6yup3b0NTUBJhcfO5hd/b1sAcjxlPtZWWyUFhKx8fnA9QfE2IgBWb2SzZUcPtRtvDG6
         Q3Gsa5Pxa0ayOdz/WeIS/1EB3h0xo/0KPoX+HEjOvz0hMYSwVc4cyOzoUTVOXH2RqxhW
         1wRPnyOTYdMwGl1UW9hggqrBvWbGrrdVUl+GauTOUhZSVzT9KcSyGhbrVxouKlv2v+RR
         +rBw==
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
Subject: [PATCH 4.15 15/64] extcon: int3496: process id-pin first so that we start with the right status
Date: Mon, 26 Feb 2018 21:21:52 +0100
Message-Id: <20180226202154.093855446@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180226202153.453363333@linuxfoundation.org>
References: <20180226202153.453363333@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593496425033407350?=
X-GMAIL-MSGID: =?utf-8?q?1593496604945141933?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
 
