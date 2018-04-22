Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+tPBQqfbwHA1YKkTYlTzX0LtgQHXOKTkRuw2WlvViZSnFGyBxyTB/VE7ketcSHnF6hrMTY
ARC-Seal: i=1; a=rsa-sha256; t=1524406408; cv=none;
        d=google.com; s=arc-20160816;
        b=sw2uY9aGDDdAFIFNCLD2NqQxiEP/Gy/CIr5gQV9AgVfVYTDGzBmqHbBwXy0eLHRRJT
         uSKsqMJ7AkYK/Lki1VhClsBRH1nxkfa1K+GcZF9Wdh4iM3uoTsIfwK4lSzvfcw593Rg2
         LpVfAZ8gSX2cH45qtITUflaPMT+IvOmOV6kc6p9ilwpE6oI4GCtxxzgj2rEKmT8Rvdja
         ddcXWfs3113RWjRMedXg/WYVhlXV6LMdtIG0y70Yn1vXrWHSdMtWCERsufuZLn3CuwJ/
         sZkBfdKiqfI98T2j2swcMq55qjdj9kYawIFkC2lizOfk8qNydIWGlFGWQ92bJHnhdcu7
         iozQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=QH/e4IU4k7dDJe0R7GDdzzFRTdyyFHeOnc2LNEyvINk=;
        b=Vhx3seY/EAo7eLTA0ZIJckv73cceDcck55Nbl51lVZY0cji89ph0vcOSCk9/hUO1E2
         dzpNA92ITExPZ/OlWNrkLO9FecClbjBmczQqZKlzOvFeZMMGoh1yaTZmtc81AWPtk/0j
         Yw5po7xPg50V5NcguNLXzsGWAS4gtP3kUgl2r1Ge0Ws2xEzMb+5bIBzBtkh6Rw+euKVU
         6qhYg/5/7qF9kKPVeUusl6b4H5jq/Y9evOaAIOzWj3dYhyMUYARvWBpOOLFOG8zMEfCy
         LzeFtSxTJdcqOSMAJzewBg7tAHwmvr5alpyOyBtkis1mTWHyF7rFM73FQdtn9v4RdsMi
         Q1Ag==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Nicholas Piggin <npiggin@gmail.com>,
	Vasant Hegde <hegdevasant@linux.vnet.ibm.com>,
	Stewart Smith <stewart@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 4.9 25/95] powerpc/powernv: Handle unknown OPAL errors in opal_nvram_write()
Date: Sun, 22 Apr 2018 15:52:54 +0200
Message-Id: <20180422135211.462498031@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135210.432103639@linuxfoundation.org>
References: <20180422135210.432103639@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598454937101435263?=
X-GMAIL-MSGID: =?utf-8?q?1598455973943873783?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nicholas Piggin <npiggin@gmail.com>

commit 741de617661794246f84a21a02fc5e327bffc9ad upstream.

opal_nvram_write currently just assumes success if it encounters an
error other than OPAL_BUSY or OPAL_BUSY_EVENT. Have it return -EIO
on other errors instead.

Fixes: 628daa8d5abf ("powerpc/powernv: Add RTC and NVRAM support plus RTAS fallbacks")
Cc: stable@vger.kernel.org # v3.2+
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Reviewed-by: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>
Acked-by: Stewart Smith <stewart@linux.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/powerpc/platforms/powernv/opal-nvram.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/arch/powerpc/platforms/powernv/opal-nvram.c
+++ b/arch/powerpc/platforms/powernv/opal-nvram.c
@@ -59,6 +59,10 @@ static ssize_t opal_nvram_write(char *bu
 		if (rc == OPAL_BUSY_EVENT)
 			opal_poll_events(NULL);
 	}
+
+	if (rc)
+		return -EIO;
+
 	*index += count;
 	return count;
 }
