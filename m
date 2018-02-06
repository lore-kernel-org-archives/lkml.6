Return-Path: <prvs=568516f6c=stanislav.nijnikov@wdc.com>
X-Google-Smtp-Source: AH8x224aNX8pK7IP1eiTfBJXXqkawSU7bvFNE3XhmyohK0hZRj+oSa2XMG8Ri12VKcHunXoZLWPN
ARC-Seal: i=1; a=rsa-sha256; t=1517933192; cv=none;
        d=google.com; s=arc-20160816;
        b=EYZJpfOhTV9YMzKFl1HVhYukiRV7Du9BTvAhV6M7Xj1DOXxsqv7xgy3wLmmtCYKdEt
         v8a8aLqvOArMM9KwWGyqxe57jLt0y420PCpKEfUz3WrTx3BKHpNwqntOJ/vfXXjga7WO
         Ur2c06XWObQlxpdJRFI1glrYeA3IjVLIKLtlf6pIc/cgtsYuTEDADHCmASBLXXOyNL7P
         arf978m4yTwbWQ81I1Cv6lgD1OHcKnHHuaiUYWMCI+FRuPkw2EDD/4/aLoa5hfAPzhzf
         9MW2BNl+ElPLoqbfSOG54ocDvV4FVIJc+iGBEm11hxlOwvUJ49H49WV6I0voTMNTo/ds
         oHfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=Km4K9Gv7ml9GwiVaCQ82xHsTUTwr3uZXrQ9f6NpReiE=;
        b=eOZ+WduwkFUnPwTETaT8z3DrJUPGrz9O/mdssztLoiIv6GdFNWgFRMuCESGD3oppkS
         uZ8z4NqBCCGF3j1GrBXsToSMikp+PeJQFhky/BXErJkP8ehfeUa0Y014v0vCPChO16Xm
         QbK5fyjkxgyFfewhL01IyqwT/AawkDBf4bBH/miQH+HfbUn6Oyd8pa0LuT5u8GjBesZz
         z1i8E91XTsqnD0rS7l/SJgQhx63NPAjp7+8xVW5M6tyEwBafWKrKfD7PBH6ExcssEKYm
         7pwTfXKWHThLkmt3KY0Fjb8Pj9vFV40uffzGRv+lPLDHvIRjF28eAdj8SFZ5QDR5qbNC
         XifQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@wdc.com header.s=dkim.wdc.com header.b=K35liTxn;
       spf=pass (google.com: domain of prvs=568516f6c=stanislav.nijnikov@wdc.com designates 68.232.143.124 as permitted sender) smtp.mailfrom=prvs=568516f6c=stanislav.nijnikov@wdc.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@wdc.com header.s=dkim.wdc.com header.b=K35liTxn;
       spf=pass (google.com: domain of prvs=568516f6c=stanislav.nijnikov@wdc.com designates 68.232.143.124 as permitted sender) smtp.mailfrom=prvs=568516f6c=stanislav.nijnikov@wdc.com
X-IronPort-AV: E=Sophos;i="5.46,469,1511798400";
   d="scan'208";a="167144201"
From: Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
To: linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	gregkh@linuxfoundation.org,
	jaegeuk@kernel.org
Cc: alex.lemberg@wdc.com,
	Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
Subject: [PATCH v5 00/11] ufs: sysfs: read-only access to device
Date: Tue,  6 Feb 2018 18:06:12 +0200
Message-Id: <1517933183-30892-1-git-send-email-stanislav.nijnikov@wdc.com>
X-Mailer: git-send-email 2.7.4
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591668315307524736?=
X-GMAIL-MSGID: =?utf-8?q?1591668315307524736?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This patch introduces sysfs entries that will provide read-only access to
device management data that could be received with UFS query requests.
User-space applications will be able to read UFS device descriptors,
flags and attributes. This will allow to get full UFS device configuration
and its status. The descriptors are provided as set of files representing
its parameters. The flags are using "true"/"false" representation of
their value. The attributes are shown as hexadecimal value. The
descriptors, attributes and flags are placed in separate subfolders under
the UFS device sysfs entry (/sys/bus/platform/drivers/ufshcd/*/). The
string descriptor subfolder contains five string descriptors defined by
UFS specification 2.1. The LUN specific descriptor and attribute are 
placed under corresponding SCSI device sysfs entries
(/sys/class/scsi_device/*/device/).
In addition the patch presents an additional field in the
scsi_host_template structure - struct attribute_group **sdev_group.
This field allows to define groups of attributes. It will provide an
ability to use binary attributes in addition to device attributes and
to group them under subfolders if necessary.

Changelog:
v4 -> v5
Added "scsi: " to clarify the patch naming
The scsi: ufs: sysfs: unit descriptor was split to two patches
"scsi: host template attribute groups" and "scsi: ufs: sysfs: unit
descriptor"
The "const" modificator was added to the sdev_groups member type and
all corresponding data structures. The type conversions in the relative
calls of sysfs_create_groups/sysfs_remove_groups were cleared.
The ufs_desc_param_size enumeration was replaced with numeric constants
The UFS_LUN_ATTRIBUTE macro was removed
The be*_to_cpu function calls were replaced with corresponding 
get_unaligned_be* calls
The legal information was cut leaving only the SPDX line and the
copyright information

v3 -> v4
Additional patch that introduces default attributes group for the
existing ufs sysfs entries (rpm_lvl and spm_lvl)
The ufs_sysfs_read_desc_param function calls to ufshcd_read_desc_param
insted of ufshcd_query_descriptor_retry to avoid code duplication.
The code was updated to remove the checkpatch error "ERROR: Macros 
with complex values should be enclosed in parentheses"
Added "_" to macros parameters to remove "#undef DEVICE_CLASS"
The legal information was updated to satisfy the SPDX requirements
The date in Documentation/ABI/testing/sysfs-driver-ufs was updated.

v2 -> v3
The Makefile is updated to make ufs-sysfs.c part of the ufshcd module.
The unnecessary EXPORT_SYMBOL were removed
Added a legal info header to the new files
The date in Documentation/ABI/testing/sysfs-driver-ufs was updated.

v1 -> v2
Provided additional description for the changes

Stanislav Nijnikov (11):
  scsi: ufs: sysfs: attribute group for existing sysfs entries.
  scsi: ufs: sysfs: device descriptor
  scsi: ufs: sysfs: interconnect descriptor
  scsi: ufs: sysfs: geometry descriptor
  scsi: ufs: sysfs: health descriptor
  scsi: ufs: sysfs: power descriptor
  scsi: ufs: sysfs: string descriptors
  scsi: host template attribute groups
  scsi: ufs: sysfs: unit descriptor
  scsi: ufs: sysfs: flags
  scsi: ufs: sysfs: attributes

 Documentation/ABI/testing/sysfs-driver-ufs | 804 +++++++++++++++++++++++++++++
 drivers/scsi/scsi_sysfs.c                  |  12 +
 drivers/scsi/ufs/Makefile                  |   3 +-
 drivers/scsi/ufs/ufs-sysfs.c               | 737 ++++++++++++++++++++++++++
 drivers/scsi/ufs/ufs-sysfs.h               |  17 +
 drivers/scsi/ufs/ufs.h                     | 115 ++++-
 drivers/scsi/ufs/ufshcd.c                  | 218 ++------
 drivers/scsi/ufs/ufshcd.h                  |  34 ++
 include/scsi/scsi_host.h                   |   6 +
 9 files changed, 1755 insertions(+), 191 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-driver-ufs
 create mode 100644 drivers/scsi/ufs/ufs-sysfs.c
 create mode 100644 drivers/scsi/ufs/ufs-sysfs.h

-- 
2.7.4
