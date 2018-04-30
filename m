Return-Path: <heikki.krogerus@linux.intel.com>
X-Google-Smtp-Source: AB8JxZrtHSD/lhTrQUq4OkTKmU//6rq19omON8/xUVXjQl/6vvgxysrbc582LQbZEtGVQ7u8sBTW
ARC-Seal: i=1; a=rsa-sha256; t=1525092121; cv=none;
        d=google.com; s=arc-20160816;
        b=NKNCEZJ5BirBheVICerXRAhZSpfIlzNyzthih7ZvfXOXzBO4P8R96m8ySIWlrhfZ4z
         5ojxDEMHAvvLqAuokou22sHo3i5TAe2pIuG8qgqEZ0c8o59HIp13gZQBnzhvFtXhrV+f
         uQBPpLaf56QHKPVKogimpFWEpfRt1QIhw+qji7Sf7rHetSpg0sfhDvJ1vdbCFgyTwlNL
         IObINyenGhbuysJGnlQJEiQdbAR35mH7WzaykD0g6eVsxwfFSxvze3oik5H3ocDMSzFX
         6ekfmJAnPbAtUJZvYhzawij9YmPcRkAYzDM0Yn11mV96uKTHgqejpXWVSWwD4s+Yjw3B
         oiGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:arc-authentication-results;
        bh=bTBHqcfOG305Os1KNAqihi9zOZnbu1xgz+adGmkzEcI=;
        b=dk/ihZvcnHo6ARz6LLduc7o0v8+SMmg0e5ts9aQGIvoEdM6ms5q3yuHxVfXNwXPJ+d
         X+SqVjgAOdllgG2oWjMh4IskXQmvvCI2JTbSnohoM1LiDYYsSQ7CP6Yo2scASeHYILhm
         MIyA+ahReaAjzhD/dIf7MeR9s0exOOdZLxiaF6YEfLU1Wt8G4p6+i7Lu7gJLyYH9ebvf
         4bdouJzYuY3WTxEuvoktrj/sdj0Cl34PnVrwJbjYwNS5qs95k56yCC1PTRXoUcFAyFO4
         p2JN23Dc4CHKyDE0/XJkfQHQM4jITFRqVOkAJBoPplKMsfdSx1GXJSG0l/nhj60c9xnA
         3kjQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of heikki.krogerus@linux.intel.com designates 134.134.136.100 as permitted sender) smtp.mailfrom=heikki.krogerus@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of heikki.krogerus@linux.intel.com designates 134.134.136.100 as permitted sender) smtp.mailfrom=heikki.krogerus@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,346,1520924400";
   d="scan'208";a="51126967"
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Hans de Goede <hdegoede@redhat.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Guenter Roeck <linux@roeck-us.net>,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org
Subject: [PATCH 0/4] usb: typec: fixes for Cherry Trails
Date: Mon, 30 Apr 2018 15:41:54 +0300
Message-Id: <20180430124158.45269-1-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.17.0
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599174996532720478?=
X-GMAIL-MSGID: =?utf-8?q?1599174996532720478?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,

I now have a GPD Win device - Intel Cherry Trail based board with
FUSB302 USB Type-C PHY - that I started using for testing my alternate
mode patches. I noticed a few dependency issues, and some other
problems with the fusb302 driver. These were the most obvious ones. 
Hans, I included the patch for the xhci usb role mux to this series.

On top of these, the driver for INT34D3 (the PMIC) needs CHT GPIO
driver in order for it to work at least on GPD Win. If that is the
case with all CHT based platforms, we probable should make the driver
depend on the CHT GPIO, but I don't know if it is?

With CHT, the driver for fusb302 also depends in practice on the
extcon_intel_cht_wc extcon device. It would probable be possible to
check it in Kconfig, but I'm not proposing anything for that here
either. I wonder if that thing needs to be an extcon device at all?


Heikki Krogerus (4):
  platform: x86: intel_cht_int33fe: Fix dependencies
  usb: typec: tcpm: Release the role mux when exiting
  usb: typec: fusb302: Fix debugfs issue
  usb: roles: intel_xhci: Always allow user control

 drivers/i2c/busses/Kconfig                     |  3 +--
 drivers/platform/x86/Kconfig                   |  4 ++--
 drivers/usb/roles/intel-xhci-usb-role-switch.c | 15 +--------------
 drivers/usb/typec/fusb302/fusb302.c            |  9 ++++-----
 drivers/usb/typec/tcpm.c                       |  1 +
 5 files changed, 9 insertions(+), 23 deletions(-)

-- 
2.17.0
