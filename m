Return-Path: <heikki.krogerus@linux.intel.com>
X-Google-Smtp-Source: AB8JxZpKRYUt+MvApBL9nZkUPfzzDMlPg3XhU5VI7FkdZG5MOv5r9wFxOXBt0yK4b09cx8950JCr
ARC-Seal: i=1; a=rsa-sha256; t=1526044722; cv=none;
        d=google.com; s=arc-20160816;
        b=xWgS7sFxGVMF014bqDPGrnBsn5ezCQFbM610T/AOGq7HMNLMopoH22UmQGV/KCF/6b
         sa+dLKjMihMIZ4FacOCHwLzptJ2KXi34sf7L/xgaeKw3yMnbqD6BqUHxrtGleBSyzJQv
         DFaFr1TWeFFUfOuPBNHuqbgXO8M1v65Yq3AQhKmQ8toSZZbDNJ5+s18P65B5LcNAknJI
         sl5or6l92JkNWT+Y0TxzmsoOURCHVTc7oDZE4Bmrq/fSyQ4ZHMg4Anzxf6eZfdRi5Jdn
         99B0epKLkF0pSRz3x/nNubGIIieXAMBnNGBM7WEMWarSuDxzE0ZlBP+6GxxJE6UYhKxQ
         iKRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:arc-authentication-results;
        bh=quBNY2KcZ+jetdMvLz3jQ4QmVg9ktBpYWLzzKmAeHes=;
        b=BdtqMBgFzzG0AwJRULgrc7M90OIBnQTJJtJfOEZUIVkUwmDLnqK3mHCmeTVYw9U3wY
         yFJqpihVNYbPCh7GhjHSVOHV0UebW20faFvKU76KS+ebrpAi4nxs+n8oxmcbqAE3Ueg7
         av2AhyqhbS58+nwu0X2YC0bNDDuoOtmABrpdcJQXNs3JnAg118Z54r08f9niCWcWkngr
         m99crlnf8A0mKjyVsj+nlBlq6EJahPCgC9U3MJo0Cok2UhbrO1RzXI1Qxk4jVOFcAsq2
         kaWmjKCphdduOSX9QzhWv37cTITrjhQmKXQa0vWFqJMZIPImk7U4JRBuKIaORThXifzq
         h5WA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of heikki.krogerus@linux.intel.com designates 134.134.136.24 as permitted sender) smtp.mailfrom=heikki.krogerus@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of heikki.krogerus@linux.intel.com designates 134.134.136.24 as permitted sender) smtp.mailfrom=heikki.krogerus@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,388,1520924400";
   d="scan'208";a="54341707"
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Guenter Roeck <linux@roeck-us.net>,
	Hans de Goede <hdegoede@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jun Li <jun.li@nxp.com>,
	Mats Karrman <mats.dev.list@gmail.com>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH v3 0/5] usb: typec: Support for Alternate Modes
Date: Fri, 11 May 2018 16:18:33 +0300
Message-Id: <20180511131838.62064-1-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.17.0
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600173870143891616?=
X-GMAIL-MSGID: =?utf-8?q?1600173870143891616?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,

This is the third version of my proposal for more complete alternate
mode support. In this version I'm including a proposal for the mux
handling. Basically, I'm proposing that every supported alternate will
have its own mux handle. That should allow us to support multiple
alternate modes at the same time. There is also a small change to how
I handled enter/exit mode commands. Now the alternate mode drivers
will need to check if Enter Mode command ACK/NAK. The ->enter callback
is not called in those cases separately. The typec_altmode_enter/exit
functions are used only when the command is initiated. Other than
that, only minor tuning.


v2 commit message:

This is second version of my proposal for more complete USB Type-C
Alternate Mode support. The original proposal can be read from here:
https://www.spinics.net/lists/linux-usb/msg161098.html

These patches now depend on series from Hans where he is introducing
mux handling support for USB Type-C and USB in general:
https://lkml.org/lkml/2018/3/2/340

The major difference compared to v1 is that I'm proposing change to
the sysfs ABI we have for the alternate mode devices. The files are
not changed, but they are moved to the parent directory from the
mode<index> folder. Since the alternate mode devices are not yet used
and in practice not supported in mainline, I felt brave enough to
propose that.

The reason for removing the mode<index> folder is because as in patch
1/3 I now create a device for every mode of every SVID, there will
never be more then one mode folder. I.e. the folder serves no purpose.
The mode<index> is still kept for now, but it's just deprecated.

There are no alternate mode drivers included yet in this version.


Original commit message (subject was "usb: typec: alternate mode
bus"):

The bus allows SVID specific communication with the partners to be
handled in separate drivers for each alternate mode.

Alternate mode handling happens with two separate logical devices:
1. Partner alternate mode devices which represent the alternate modes
   on the partner. The driver for them will handle the alternate mode
   specific communication with the partner using VDMs.
2. Port alternate mode devices which represent connections from the
   USB Type-C port to devices on the platform.

The drivers will be bind to the partner alternate modes. The alternate
mode drivers will need to deliver the result of the negotiated pin
configurations to the rest of the platform (towards the port alternate
mode devices). This series includes API for that, however, not the
final implementation yet.

The connections to the other devices on the platform the ports have
can be described by using the remote endpoint concept [1][2] on ACPI
and DT platforms, but I have no solution for the "platform data" case
where we have neither DT nor ACPI to describe the connections for us.

[1] Documentation/devicetree/bindings/graph.txt
[2] Documentation/acpi/dsd/graph.txt


Heikki Krogerus (5):
  usb: typec: mux: Get the mux identifier from function parameter
  usb: typec: Register a device for every mode
  usb: typec: Bus type for alternate modes
  usb: typec: pi3usb30532: Start using generic state values
  usb: typec: tcpm: Support for Alternate Modes

 Documentation/ABI/obsolete/sysfs-class-typec |  48 ++
 Documentation/ABI/testing/sysfs-bus-typec    |  51 ++
 Documentation/ABI/testing/sysfs-class-typec  |  62 +--
 Documentation/driver-api/usb/typec_bus.rst   | 136 ++++++
 drivers/usb/typec/Makefile                   |   2 +-
 drivers/usb/typec/bus.c                      | 423 +++++++++++++++++
 drivers/usb/typec/bus.h                      |  38 ++
 drivers/usb/typec/class.c                    | 472 ++++++++++++-------
 drivers/usb/typec/mux.c                      |   6 +-
 drivers/usb/typec/mux/pi3usb30532.c          |  11 +-
 drivers/usb/typec/tcpm.c                     | 179 +++++--
 include/linux/mod_devicetable.h              |  15 +
 include/linux/usb/tcpm.h                     |   9 -
 include/linux/usb/typec.h                    |  51 +-
 include/linux/usb/typec_altmode.h            | 142 ++++++
 include/linux/usb/typec_mux.h                |   2 +-
 scripts/mod/devicetable-offsets.c            |   4 +
 scripts/mod/file2alias.c                     |  13 +
 18 files changed, 1347 insertions(+), 317 deletions(-)
 create mode 100644 Documentation/ABI/obsolete/sysfs-class-typec
 create mode 100644 Documentation/ABI/testing/sysfs-bus-typec
 create mode 100644 Documentation/driver-api/usb/typec_bus.rst
 create mode 100644 drivers/usb/typec/bus.c
 create mode 100644 drivers/usb/typec/bus.h
 create mode 100644 include/linux/usb/typec_altmode.h

-- 
2.17.0
