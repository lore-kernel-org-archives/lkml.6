Return-Path: <heikki.krogerus@linux.intel.com>
X-Google-Smtp-Source: AG47ELuYPMMytuQINy7aOqZ4v7OCJgO9zczFlG9frHJOSSzLWMFt4Tcme3THRuy5Q8y3hqDEKsDw
ARC-Seal: i=1; a=rsa-sha256; t=1520608762; cv=none;
        d=google.com; s=arc-20160816;
        b=jgPtiC4EkNdIyt2Y1yWkkjK7qw8u/50X4TMKt1049VswUYevBZPKSMIef4TdhtrEQQ
         HskkjINEKkmEkJ2bymq9psoL/Kkqr+9Pj6Q/1TtrAsIJyQfJ6i0WkvvJeBF6bbdsVOOH
         sxptsrsjgZHgNEeL0hK9EgFVFx3RAyZ/eqPrSTcjYs7uONQBvDhIx3SIBWcwGiAx4nQf
         A1cDRWDd/LAnzS7L6FtC+IbOgWRSifs4/ANJxfOLqDNqQFsLxng27lrXYR8d5X4mzVEl
         tUEGFMinTI4GflwIWyhlh10OWILzCBIdERXkl8sZJv+cPldgY2aQBTI+UCIuQpvRX5pe
         Ftdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:arc-authentication-results;
        bh=3toE/9cUJh0dyciioVmCvtGBsP2t2Py/0S4haFNs7hY=;
        b=zG+wE+U1d3tlguZs7P2BgajOqBb2f7jTRBRDwD6KtqRTSZVqjnW+rdACVph1IzgAXx
         HiRoYqR/Er0M5Uwmo74bvYQxfwGzyghNh7QGCUYeP7xlj4fAwB+DrU+oaN0hgwbOOtej
         OM6eF328xdNxgKQqLvb0wlAXGUztMAObKUgRXCIOG9qbzzY1LEgkrMUcXuyXCqP+1NOn
         ONlTW1mvO1r82Fyu0fy8uajKU7AkmDcw0G/r6n+Q7N1cZuusspQR7f44Em0CRAroe7iC
         +Gi38eZL+JoGb7eRe2ulsT/jWjuCsxebsB/Ockxo+n+g4uXYYY5ZzC3eNpcUPUl0BSBC
         XHaQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of heikki.krogerus@linux.intel.com designates 134.134.136.126 as permitted sender) smtp.mailfrom=heikki.krogerus@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of heikki.krogerus@linux.intel.com designates 134.134.136.126 as permitted sender) smtp.mailfrom=heikki.krogerus@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,446,1515484800";
   d="scan'208";a="36826652"
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Hans de Goede <hdegoede@redhat.com>
Cc: Jun Li <jun.li@nxp.com>,
	"Regupathy, Rajaram" <rajaram.regupathy@intel.com>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 0/3] usb: typec: Support for Alternate Modes
Date: Fri,  9 Mar 2018 18:19:15 +0300
Message-Id: <20180309151918.22048-1-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.16.1
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594473853502816040?=
X-GMAIL-MSGID: =?utf-8?q?1594473853502816040?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi guys,

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


Heikki Krogerus (3):
  usb: typec: Register a device for every mode
  usb: typec: Bus type for alternate modes
  usb: typec: tcpm: Support for Alternate Modes

 Documentation/ABI/obsolete/sysfs-class-typec |  48 +++
 Documentation/ABI/testing/sysfs-bus-typec    |  51 ++++
 Documentation/ABI/testing/sysfs-class-typec  |  62 +---
 Documentation/driver-api/usb/typec_bus.rst   | 143 +++++++++
 drivers/usb/typec/Makefile                   |   2 +-
 drivers/usb/typec/bus.c                      | 421 ++++++++++++++++++++++++++
 drivers/usb/typec/bus.h                      |  37 +++
 drivers/usb/typec/class.c                    | 424 ++++++++++++++++++---------
 drivers/usb/typec/tcpm.c                     | 156 +++++++---
 include/linux/mod_devicetable.h              |  15 +
 include/linux/usb/typec.h                    |  50 +---
 include/linux/usb/typec_altmode.h            | 136 +++++++++
 scripts/mod/devicetable-offsets.c            |   4 +
 scripts/mod/file2alias.c                     |  13 +
 14 files changed, 1285 insertions(+), 277 deletions(-)
 create mode 100644 Documentation/ABI/obsolete/sysfs-class-typec
 create mode 100644 Documentation/ABI/testing/sysfs-bus-typec
 create mode 100644 Documentation/driver-api/usb/typec_bus.rst
 create mode 100644 drivers/usb/typec/bus.c
 create mode 100644 drivers/usb/typec/bus.h
 create mode 100644 include/linux/usb/typec_altmode.h

-- 
2.16.1
