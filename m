Return-Path: <leo.yan@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1522379746; cv=none;
        d=google.com; s=arc-20160816;
        b=QzXkxTPfTRV0tBReKILSPkbuf+SS9HmAV/UUMxm1PCuKPDqvasjFETqW5gkoiRK6uv
         p2DLqdCggBM4SIW+2AQ9254fgQrNlKs5XRlGKNZE37bt7VP9uZ6Y+oeINnM9xgdG58Ny
         UwvZGqRK1i1KUaK32X7LiPx16O/pxKkjgBpA9S5ApyiqHGi8JzjtigtlH8qcsKCr78qx
         mrwF41is8Fy0rWF1OuZ0W3wj4frxg7XBt+1qIjR6cXQtPQYUurQm4AsEKN9MQF4haQ1R
         E0Rl+6BjIxfOOle81eS2TF15hWRKYIChc1tsPucFbwSlc6TZBzeG6Z4v6RTW0nAywVby
         OhZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=g8hRWBH9Ffr8aq1M++fL3sQ9CcLWhWZkFaFf/4I20MQ=;
        b=NDVXUVF0/OlF9VpiQO8FVwXcncv9d2gZcyw7cCFzsYSGVXLdrwiyD6uUHBeE3iEWgi
         Eluhc3cBExi0VLrvOWBnsaVM9ACGeAQjc8DLUQJXJlw/vXoXiaGG4NWv3j9bvSEzpXgy
         HkeRTRZ7a1Su+c0uzI3Ov/wQ6yPbqftm3IwliuqJdGFoFK0mBDj4VKoUDTjZn7tPKqUC
         7ti8oIpcwBbA2DPfBZ0KMFbpZKNGNzKoTGU062wlrHZatSTLh6RYUCmyDjMJEgXtW/9p
         mUp5eJYqeWIwB5knsGeipboc+zQ5eHSjbj3zPR8GDHD6AeC9YQ3RNqo7KvpBv7q1twph
         bXgQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=GLWOQTv4;
       spf=pass (google.com: domain of leo.yan@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=leo.yan@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=GLWOQTv4;
       spf=pass (google.com: domain of leo.yan@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=leo.yan@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AIpwx4/T8uY17IfiY71hFu/7ZK2I9ULoXw2Dm4S5vUsbCd4jBVt8hqpeZOA0t1j0uO1tw/MOAgU9Ow==
From: Leo Yan <leo.yan@linaro.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	coresight@lists.linaro.org,
	Kim Phillips <kim.phillips@arm.com>,
	Mike Leach <mike.leach@linaro.org>
Cc: Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v4 0/6] Coresight: Support panic kdump
Date: Fri, 30 Mar 2018 11:15:18 +0800
Message-Id: <1522379724-30648-1-git-send-email-leo.yan@linaro.org>
X-Mailer: git-send-email 2.7.4
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596330865086330396?=
X-GMAIL-MSGID: =?utf-8?q?1596330865086330396?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This patch set is to explore Coresight tracing data for postmortem
debugging.  When kernel panic happens, the Coresight panic kdump can
help to save on-chip tracing data and tracer metadata into DRAM, later
relies on kdump and crash/perf tools to recovery tracing data for
"offline" analysis.

The documentation is important to understand the purpose of Coresight
panic kdump, the implementation of framework and usage. Patches 0001
and patch 0002 are used for creating new sub directory for placing
Coresight docs and add a new doc for Coresight panic kdump.

Patch 0003 introduces the simple panic kdump framework which provides
helper functions can be used by Coresight devices, and it registers
panic notifier for dump tracing data.

Patches 0004/0005 support panic kdump for ETB; Patch 0006 supports the
kdump for ETMv4.

This patch set has been reworked by following suggestions at Linaro
HKG18 connect (mainly suggestions from Mathieu, thanks a lot!), and
it's rebased on acme git tree [1] with last commit 109d59b900e7 ('perf
vendor events s390: Add JSON files for IBM z14').

Due Coresight kdump data structure has been changed significantly, the
corresponding crash extension program also has been updated for this
reason [2]; furthermore the crash extension program is updated to
dynamically generate kernel buildid according to vmlinux elf info [3],
this is a fixing for the old code which uses hard-coded buildid value.

This patch set has been verified on 96boards Hikey620 with Coresight
enabling by the sysFS interface.  Also the updated crash extension
program has been verified to cowork with Coresight panic kdump and it
successfully extracts tracing data from the vmcore and finally can be
decoded by perf tool.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git
[2] https://git.linaro.org/people/leo.yan/crash.git/tree/extensions/csdump.c
[3] https://git.linaro.org/people/leo.yan/crash.git/tree/extensions/csdump_buildid.c

Changes from v3:
* Following Mathieu suggestion, reworked the panic kdump framework,
  used kdump array to maintain source and sink device handlers;
* According to Mathieu suggestion, optimized panic notifier to
  firstly dump panic CPU tracing data and then dump other CPUs tracing
  data;
* Refined doc to reflect these implementation changes;
* Changed ETMv4 driver to add source device handler at probe phase;
* Refactored crash extension program to reflect kernel changes.

Changes from v2:
* Add the two patches for documentation.
* Following Mathieu suggestion, reworked the panic kdump framework,
  removed the useless flag "PRE_PANIC".
* According to comment, changed to add and delete kdump node operations
  in sink enable/disable functions;
* According to Mathieu suggestion, handle kdump node
  addition/deletion/updating separately for sysFS interface and perf
  method.

Changes from v1:
* Add support to dump ETMv4 meta data.
* Wrote 'crash' extension csdump.so so rely on it to generate 'perf'
  format compatible file.
* Refactored panic dump driver to support pre & post panic dump.

Changes from RFC:
* Follow Mathieu's suggestion, use general framework to support dump
  functionality.
* Changed to use perf to analyse trace data.

Leo Yan (6):
  doc: Add Coresight documentation directory
  doc: Add documentation for Coresight panic kdump
  coresight: Support panic kdump functionality
  coresight: tmc: Hook callback for panic kdump
  coresight: Set and clear sink device handler for kdump node
  coresight: etm4x: Support panic kdump

 Documentation/trace/coresight-cpu-debug.txt        | 187 ----------
 Documentation/trace/coresight.txt                  | 383 ---------------------
 .../trace/coresight/coresight-cpu-debug.txt        | 187 ++++++++++
 .../trace/coresight/coresight-panic-kdump.txt      | 130 +++++++
 Documentation/trace/coresight/coresight.txt        | 383 +++++++++++++++++++++
 MAINTAINERS                                        |   5 +-
 drivers/hwtracing/coresight/Kconfig                |   9 +
 drivers/hwtracing/coresight/Makefile               |   1 +
 drivers/hwtracing/coresight/coresight-etm-perf.c   |   5 +
 drivers/hwtracing/coresight/coresight-etm4x.c      |  27 ++
 drivers/hwtracing/coresight/coresight-etm4x.h      |  15 +
 .../hwtracing/coresight/coresight-panic-kdump.c    | 199 +++++++++++
 drivers/hwtracing/coresight/coresight-priv.h       |  12 +
 drivers/hwtracing/coresight/coresight-tmc-etf.c    |  30 ++
 drivers/hwtracing/coresight/coresight.c            |  16 +-
 include/linux/coresight.h                          |   4 +
 16 files changed, 1019 insertions(+), 574 deletions(-)
 delete mode 100644 Documentation/trace/coresight-cpu-debug.txt
 delete mode 100644 Documentation/trace/coresight.txt
 create mode 100644 Documentation/trace/coresight/coresight-cpu-debug.txt
 create mode 100644 Documentation/trace/coresight/coresight-panic-kdump.txt
 create mode 100644 Documentation/trace/coresight/coresight.txt
 create mode 100644 drivers/hwtracing/coresight/coresight-panic-kdump.c

-- 
2.7.4
