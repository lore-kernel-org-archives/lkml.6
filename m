Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x2254h5EpKG4jyJ2vFR6ESKLTeinjhLsz3h1LhVcA2WfzTx/YiWoia/CxBJw43f9WvjPccdf/
ARC-Seal: i=1; a=rsa-sha256; t=1517591652; cv=none;
        d=google.com; s=arc-20160816;
        b=LFk8w7U3RfHLhUj6xl6gY1WxCx4Ywg5mnZTbZ0amRtHjBcHlCc7krUw7vgJsmMO7Zc
         HvA6pmCTonuoon/YOQnxsnk04KAoDnrwnWaLjH1soyU0Dvxb5moci0sauiOy0v4u4tXX
         /M0C1t1Aaix+6p4y15XeJx8tklmBRcqfuoFCTo3mMe67EuqFxOOzMC89/wLsyaQ9c7LC
         No+Z2akN8ZcsQarApv/22SMavJry0GShBgA0j7CvifSpbqSPxKdc6Vhuv6otzOSw/qcu
         e7mmtGG5aVuuZP27fH1yvYGEU1s9wC0x/KeG45mbKrJxd6CiVQGGvv3KK84jUyyUo1b4
         /fHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=p958Ppf+UT7T4BfwskTo/gBqr+T84NPd9ddwBORGJic=;
        b=AZftIt5DKm/vIH9O6igF6QGE4JjRNm9Zkqfp2MwxnOWEflsmia755yNMynNTlV2xhR
         Rn3zPPzt17WTzFd+Qu7FYiP3FpySdQU8r1rXUwk9GL8xomGAs+hvGF2iOzrwGeBTUPeq
         sQZj0P2RuateOVQLnAmxPrpCcpOjB+BKqliSoSC5p7d5a9xz1bSXj7waDcVcPYD3Wv+q
         XcB27KIWcGwDdmYa5Q3p16bDWvvV4PuUByPQpY/H9uMZLXRMEXo4jK2pFPNoe2S/kh3P
         5FIWDLShHyVLI4AcO22S2aFIVptj1NxJR6cgONk2nCwAmzdKujTdh7xMAHZu7h2wYEOz
         mCbA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Tomas Winkler <tomas.winkler@intel.com>,
	Alexander Usyskin <alexander.usyskin@intel.com>
Subject: [PATCH 4.14 146/156] mei: me: allow runtime pm for platform with D0i3
Date: Fri,  2 Feb 2018 17:58:47 +0100
Message-Id: <20180202140846.979795697@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140840.242829545@linuxfoundation.org>
References: <20180202140840.242829545@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591310183968671557?=
X-GMAIL-MSGID: =?utf-8?q?1591310183968671557?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tomas Winkler <tomas.winkler@intel.com>

commit cc365dcf0e56271bedf3de95f88922abe248e951 upstream.

>From the pci power documentation:
"The driver itself should not call pm_runtime_allow(), though. Instead,
it should let user space or some platform-specific code do that (user space
can do it via sysfs as stated above)..."

However, the S0ix residency cannot be reached without MEI device getting
into low power state. Hence, for mei devices that support D0i3, it's better
to make runtime power management mandatory and not rely on the system
integration such as udev rules.
This policy cannot be applied globally as some older platforms
were found to have broken power management.

Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
Reviewed-by: Alexander Usyskin <alexander.usyskin@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/misc/mei/pci-me.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/drivers/misc/mei/pci-me.c
+++ b/drivers/misc/mei/pci-me.c
@@ -238,8 +238,11 @@ static int mei_me_probe(struct pci_dev *
 	 */
 	mei_me_set_pm_domain(dev);
 
-	if (mei_pg_is_enabled(dev))
+	if (mei_pg_is_enabled(dev)) {
 		pm_runtime_put_noidle(&pdev->dev);
+		if (hw->d0i3_supported)
+			pm_runtime_allow(&pdev->dev);
+	}
 
 	dev_dbg(&pdev->dev, "initialization successful.\n");
 
