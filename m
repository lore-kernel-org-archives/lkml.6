Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/73yaJ1jPtzJxwTneuSXQF3q5kduLRxHAx/Zac8SUl+Zi39WkmAPCAa025buR1iBApgmJN
ARC-Seal: i=1; a=rsa-sha256; t=1523981007; cv=none;
        d=google.com; s=arc-20160816;
        b=ugNxtFhEdsdIFDWlOwaDmVYtdMIAREH7MImfgg+W4VB/IplPzw1neWWZR+6vDAFev6
         xG7HuymRMJYj09o/rJVgkIX/n7EMdSVXLMA9HS+53mekPHNWKFvkHhfyUnqpA51+cK2r
         h2f86Ft/AvPw1w94pGZQAoxUko24pye4irDLE0FmcM/0vYtl18LT3dwWfSkFsOfxsWql
         Jpkc3d0gAAzmjbMMINk+fV3QV867gcgl02OdBn8mOZF5VboW1+rlPNR6CMqnKggmLfsD
         68sgn1dc9UHWFdBXzSHyyvQlBZuErO9adiXtMqN520/U+2LM3YUqep91pqCKCCs0E6dy
         Nb+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=WUUCpIPj28Uu5Bo/xyMOQDk2iA10WrRU7ZMIBjRphMk=;
        b=vPYh//yaYvKB1pLHn70ImCAmoLXVoCc5w0lLyIBRmeqWgrpW1uiDnNgBKA7A/I7G0+
         TkSLFpSTZqpfX7TvdVt+2HWqGsi+nWSli7u82rAGjH44BZ+kUtEgd/gCdCGokhGZiETh
         RbRKPC7H13/3bpJM5W4dYv2KJC9mbQpkDyJqdSs9EqNtzRzmWGF3o2cruu3lEbAb4C7F
         cH1X+l7crRTKN9xoKEStFHkI9ewVYeALdAGnq+hgn2yhQG5Dtf5iG7P9oLL/bWtpk0Cc
         /JtRzQeqgRcTvV7Eh5aVH6y8iHwsBH4p/488XmBGNX942lILTYfqdowElxRIK/gjg9mE
         be6g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 46.44.180.42 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 46.44.180.42 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Corey Minyard <cminyard@mvista.com>,
	Laura Abbott <labbott@redhat.com>,
	Bill Perkins <wmp@grnwood.net>
Subject: [PATCH 4.15 14/53] ipmi: Fix some error cleanup issues
Date: Tue, 17 Apr 2018 17:58:39 +0200
Message-Id: <20180417155723.822190875@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180417155723.091120060@linuxfoundation.org>
References: <20180417155723.091120060@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598009704245435970?=
X-GMAIL-MSGID: =?utf-8?q?1598009908713394928?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Corey Minyard <cminyard@mvista.com>

commit cc095f0ac1f7c200e51a5c2a78a43c9f42049dbb upstream.

device_remove_group() was called on any cleanup, even if the
device attrs had not been added yet.  That can occur in certain
error scenarios, so add a flag to know if it has been added.

Also make sure we remove the dev if we added it ourselves.

Signed-off-by: Corey Minyard <cminyard@mvista.com>
Cc: stable@vger.kernel.org # 4.15
Cc: Laura Abbott <labbott@redhat.com>
Tested-by: Bill Perkins <wmp@grnwood.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/char/ipmi/ipmi_si_intf.c |   18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

--- a/drivers/char/ipmi/ipmi_si_intf.c
+++ b/drivers/char/ipmi/ipmi_si_intf.c
@@ -252,6 +252,9 @@ struct smi_info {
 	/* Default driver model device. */
 	struct platform_device *pdev;
 
+	/* Have we added the device group to the device? */
+	bool dev_group_added;
+
 	/* Counters and things for the proc filesystem. */
 	atomic_t stats[SI_NUM_STATS];
 
@@ -2025,8 +2028,8 @@ int ipmi_si_add_smi(struct si_sm_io *io)
 	if (initialized) {
 		rv = try_smi_init(new_smi);
 		if (rv) {
-			mutex_unlock(&smi_infos_lock);
 			cleanup_one_si(new_smi);
+			mutex_unlock(&smi_infos_lock);
 			return rv;
 		}
 	}
@@ -2185,6 +2188,7 @@ static int try_smi_init(struct smi_info
 			rv);
 		goto out_err_stop_timer;
 	}
+	new_smi->dev_group_added = true;
 
 	rv = ipmi_register_smi(&handlers,
 			       new_smi,
@@ -2238,7 +2242,10 @@ static int try_smi_init(struct smi_info
 	return 0;
 
 out_err_remove_attrs:
-	device_remove_group(new_smi->io.dev, &ipmi_si_dev_attr_group);
+	if (new_smi->dev_group_added) {
+		device_remove_group(new_smi->io.dev, &ipmi_si_dev_attr_group);
+		new_smi->dev_group_added = false;
+	}
 	dev_set_drvdata(new_smi->io.dev, NULL);
 
 out_err_stop_timer:
@@ -2286,6 +2293,7 @@ out_err:
 		else
 			platform_device_put(new_smi->pdev);
 		new_smi->pdev = NULL;
+		new_smi->io.dev = NULL;
 	}
 
 	kfree(init_name);
@@ -2382,8 +2390,10 @@ static void cleanup_one_si(struct smi_in
 		}
 	}
 
-	device_remove_group(to_clean->io.dev, &ipmi_si_dev_attr_group);
-	dev_set_drvdata(to_clean->io.dev, NULL);
+	if (to_clean->dev_group_added)
+		device_remove_group(to_clean->io.dev, &ipmi_si_dev_attr_group);
+	if (to_clean->io.dev)
+		dev_set_drvdata(to_clean->io.dev, NULL);
 
 	list_del(&to_clean->link);
 
