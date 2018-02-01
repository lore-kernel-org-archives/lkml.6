Return-Path: <prvs=563541312=stanislav.nijnikov@wdc.com>
X-Google-Smtp-Source: AH8x224kI25QrGvDcUNykl8/YN4cJu6zVeHAI6gdVCYppPbNo52muqWZSzJqwGloMlDddxCMyROq
ARC-Seal: i=1; a=rsa-sha256; t=1517501751; cv=none;
        d=google.com; s=arc-20160816;
        b=mbI4oHZLJkkc7HQkSD9O0wG+XhOspKh8DN7zZAuzUfXRTKRdVAkThdejU8N1QCY+E0
         wU6dCMlHUkAk21a9TL9+RboI9/OmIoBwYT0Pu3v4mguMKgaCCs869Kq6hFDNaqVs6nIy
         T5rdhO66ByCYXV0gQMidLgtuODPkDJVl+gpILagv3tIx3M7O9jzdE5T5s3Fov25EknnK
         tCjWQfXkpfmao+YdST8hg1vPc10rDpy2WAQn7BCLhGL1qpx2DcELi+NCwdc5IE/obHGy
         rnNUw/9jQDv0ZPH5lkklG7qOMGpJ+hv7Nreqjrd2AnsdQAruxQ30zk9rfeQT8I6pVCE9
         rlqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=xRW5gGwItk4SNEqHKFARH7+DKantBossizblcweHpmc=;
        b=Bqhj/gDGPo8b0WWeFq3EwbSBwktGPNr3WGg8UMxs69dDNE5GTOqgKDGPXZ338b5ZEX
         HVDbMqTKmh1IdTsOrpSk426d0uQX4zsuFGVevmmY4zv7IieXrFsLgUcFTOlcPxVv9Gx9
         7WFyRLZ2YUzjgQAwkKZ6ljLQUTZxII8tmbsfh8Oox13cGx4liqU9Z9W6U/3H5zVILp++
         nujz0MS5tUgqpI8HQcac1cwLYEHoLpSeL8VB+0SEAx0fAfe41i9JrqYi1EI/4fVEkhDs
         yOTFEXcwdu4QEAFiSpINx2pB3G/X2h+yMCgNkFIW0WM4DS5vI/HY1zUoKHMbg6UQGuSL
         A4GQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@wdc.com header.s=dkim.wdc.com header.b=PfrUz9iA;
       spf=pass (google.com: domain of prvs=563541312=stanislav.nijnikov@wdc.com designates 68.232.141.245 as permitted sender) smtp.mailfrom=prvs=563541312=stanislav.nijnikov@wdc.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@wdc.com header.s=dkim.wdc.com header.b=PfrUz9iA;
       spf=pass (google.com: domain of prvs=563541312=stanislav.nijnikov@wdc.com designates 68.232.141.245 as permitted sender) smtp.mailfrom=prvs=563541312=stanislav.nijnikov@wdc.com
X-IronPort-AV: E=Sophos;i="5.46,444,1511798400";
   d="scan'208";a="173298214"
From: Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
To: linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	gregkh@linuxfoundation.org,
	jaegeuk@kernel.org
Cc: alex.lemberg@wdc.com,
	Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
Subject: [PATCH v4 00/10] ufs: sysfs: read-only access to device descriptors, attributes and flags
Date: Thu,  1 Feb 2018 18:15:36 +0200
Message-Id: <1517501746-19075-1-git-send-email-stanislav.nijnikov@wdc.com>
X-Mailer: git-send-email 2.7.4
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591215916113851463?=
X-GMAIL-MSGID: =?utf-8?q?1591215916113851463?=
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
v3 -> v4
Additional patch the introduces default attributes group for the
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

Stanislav Nijnikov (10):
  ufs: sysfs: attribute group for existing sysfs entries.
  ufs: sysfs: device descriptor
  ufs: sysfs: interconnect descriptor
  ufs: sysfs: geometry descriptor
  ufs: sysfs: health descriptor
  ufs: sysfs: power descriptor
  ufs: sysfs: string descriptors
  ufs: sysfs: unit descriptor
  ufs: sysfs: flags
  ufs: sysfs: attributes

 Documentation/ABI/testing/sysfs-driver-ufs | 804 +++++++++++++++++++++++++++++
 drivers/scsi/scsi_sysfs.c                  |  14 +
 drivers/scsi/ufs/Makefile                  |   3 +-
 drivers/scsi/ufs/ufs-sysfs.c               | 757 +++++++++++++++++++++++++++
 drivers/scsi/ufs/ufs-sysfs.h               |  25 +
 drivers/scsi/ufs/ufs.h                     | 115 ++++-
 drivers/scsi/ufs/ufshcd.c                  | 218 ++------
 drivers/scsi/ufs/ufshcd.h                  |  34 ++
 include/scsi/scsi_host.h                   |   6 +
 9 files changed, 1785 insertions(+), 191 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-driver-ufs
 create mode 100644 drivers/scsi/ufs/ufs-sysfs.c
 create mode 100644 drivers/scsi/ufs/ufs-sysfs.h

-- 
2.7.4
