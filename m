Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 089A8C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 19:57:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7A5E20827
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 19:57:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="siSDqCk7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731172AbfAHT5w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 14:57:52 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:44061 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729738AbfAHT3y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 14:29:54 -0500
Received: by mail-lj1-f196.google.com with SMTP id k19-v6so4381278lji.11
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jan 2019 11:29:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=QROh7OCQrXt9g019C2ypOS2+SuZs8Qynl+T7q8Jh3vk=;
        b=siSDqCk7Z0J5h3bpZTII+w2f8qWy5w1NiBo/k36Y45XFn+mMGehvm+fp/hnOYYaHsy
         4e+7A9i8TkH6AXz/uG6mjxb60B6g8Eg87Z61Uek4tpD70cvh1VbfiklQAHlMgMHY8vSI
         64477AsPDjyoMOUkHzJAjSpoBEygm60r9cKOIRGOBwWTbqm+2hPxfk5VD8OPni04KHhp
         3CK3qfHyOQ58r0mZnK1Gudz2V8kqC5loNPjMsPjila/2v+D9ZzVezBhBBOWIAYysdkdc
         i10Otk/G/Qk9IDQXERrkd529nxpKbkMQZdxZZ2xETgWThuJfIvwWOGeezD+QjGZ0yv4x
         XWJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=QROh7OCQrXt9g019C2ypOS2+SuZs8Qynl+T7q8Jh3vk=;
        b=kJ7p/9Tmr7TVd/1KiJt2w0ztfq4C5SbrqdBtz37UI5JRbmxZefswj5QK211MxQeKbU
         n3AvrusYNKZsIEPNUW/EXLXpgfaV/dTfexAFAw572Z1Qg16hoj1a/iC2UtdtocjNpWbH
         PBl85X1wXNes8Iy1Oohgz2gPqDuUHnGyM+PwLq8RUtkGVu5jMSumvHnaAlJCpICQ4k8Y
         AzLkZ59PYTvJ+XulhuBm1S4dPIAhVpjPQ7EWdd5mna4K53WPzufri4gvVtLwkLsjyLSO
         RYbwUWerHZ3OExu9jmV4HMjf0wGQLaIOjk2O2mfgMaC+bEgY+W0SEcB10o2Hdep8UxfL
         1aAQ==
X-Gm-Message-State: AJcUukfbMPL9TL3FvMDhfg4ZwkYKkN1N7UsnSNZsW6wVSCu8dOkFQhaV
        OJKas8WqnyXy8Mdq+/pFwWg=
X-Google-Smtp-Source: ALg8bN5rS552hIz9niwMttO6oy4iFhLFkVMqJinAgtXWIRqdDoVCFUmY2U2AUndhg8qCnH/gdwYG2Q==
X-Received: by 2002:a2e:7615:: with SMTP id r21-v6mr1719499ljc.131.1546975791795;
        Tue, 08 Jan 2019 11:29:51 -0800 (PST)
Received: from jupiter.lan (18.158-248-194.customer.lyse.net. [158.248.194.18])
        by smtp.gmail.com with ESMTPSA id q128-v6sm9122246ljq.14.2019.01.08.11.29.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Jan 2019 11:29:51 -0800 (PST)
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>,
        David Lechner <david@lechnology.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     Sam Ravnborg <sam@ravnborg.org>, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v3 01/12] drm: drm_device.h: update comments to kernel-doc style
Date:   Tue,  8 Jan 2019 20:29:28 +0100
Message-Id: <20190108192939.15255-2-sam@ravnborg.org>
X-Mailer: git-send-email 2.12.0
In-Reply-To: <20190108192939.15255-1-sam@ravnborg.org>
References: <20190108192939.15255-1-sam@ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Updated comment style to kernel-doc format in drm_device.h

In struct drm_device there are 12 struct members without doc:
- registered
- filelist_mutex
- filelist
- irq
- vbl_lock
- event_lock
- hose
- sigdata
- sigdata.context
- sigdata.lock
- agp_buffer_map
- agp_buffer_token

They all need proper documentation, a task left for someone
that knows their usage.

drm_device is not plugged into Documentation/gpu/drm-internals.rst
as this would create a new load of warnings.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <maxime.ripard@bootlin.com>
Cc: Sean Paul <sean@poorly.run>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Jonathan Corbet <corbet@lwn.net>
---
 include/drm/drm_device.h | 199 +++++++++++++++++++++++++++++++----------------
 1 file changed, 134 insertions(+), 65 deletions(-)

diff --git a/include/drm/drm_device.h b/include/drm/drm_device.h
index 42411b3ea0c8..2b154ead9efc 100644
--- a/include/drm/drm_device.h
+++ b/include/drm/drm_device.h
@@ -25,24 +25,48 @@ struct pci_dev;
 struct pci_controller;
 
 /**
- * DRM device structure. This structure represent a complete card that
+ * struct drm_device - DRM device structure
+ *
+ * This structure represent a complete card that
  * may contain multiple heads.
  */
 struct drm_device {
-	struct list_head legacy_dev_list;/**< list of devices per driver for stealth attach cleanup */
-	int if_version;			/**< Highest interface version set */
-
-	/** \name Lifetime Management */
-	/*@{ */
-	struct kref ref;		/**< Object ref-count */
-	struct device *dev;		/**< Device structure of bus-device */
-	struct drm_driver *driver;	/**< DRM driver managing the device */
-	void *dev_private;		/**< DRM driver private data */
-	struct drm_minor *primary;		/**< Primary node */
-	struct drm_minor *render;		/**< Render node */
+	/**
+	 * @legacy_dev_list:
+	 *
+	 * List of devices per driver for stealth attach cleanup
+	 */
+	struct list_head legacy_dev_list;
+
+	/** @if_version: Highest interface version set */
+	int if_version;
+
+	/** @ref: Object ref-count */
+	struct kref ref;
+
+	/** @dev: Device structure of bus-device */
+	struct device *dev;
+
+	/** @driver: DRM driver managing the device */
+	struct drm_driver *driver;
+
+	/** @dev_private: DRM driver private data */
+	void *dev_private;
+
+	/** @primary: Primary node */
+	struct drm_minor *primary;
+
+	/** @render: Render node */
+	struct drm_minor *render;
+
 	bool registered;
 
-	/* currently active master for this device. Protected by master_mutex */
+	/**
+	 * @master:
+	 *
+	 * Currently active master for this device.
+	 * Protected by &master_mutex
+	 */
 	struct drm_master *master;
 
 	/**
@@ -63,23 +87,42 @@ struct drm_device {
 	 */
 	bool unplugged;
 
-	struct inode *anon_inode;		/**< inode for private address-space */
-	char *unique;				/**< unique name of the device */
-	/*@} */
+	/** @anon_inode: inode for private address-space */
+	struct inode *anon_inode;
+
+	/** @unique: Unique name of the device */
+	char *unique;
+
+	/**
+	 * @struct_mutex:
+	 *
+	 * Lock for others (not &drm_minor.master and &drm_file.is_master)
+	 */
+	struct mutex struct_mutex;
+
+	/**
+	 * @master_mutex:
+	 *
+	 * Lock for &drm_minor.master and &drm_file.is_master
+	 */
+	struct mutex master_mutex;
+
+	/**
+	 * @open_count:
+	 *
+	 * Usage counter for outstanding files open,
+	 * protected by drm_global_mutex
+	 */
+	int open_count;
+
+	/** @buf_lock: Lock for &buf_use and a few other things. */
+	spinlock_t buf_lock;
 
-	/** \name Locks */
-	/*@{ */
-	struct mutex struct_mutex;	/**< For others */
-	struct mutex master_mutex;      /**< For drm_minor::master and drm_file::is_master */
-	/*@} */
+	/** @buf_use: Usage counter for buffers in use -- cannot alloc */
+	int buf_use;
 
-	/** \name Usage Counters */
-	/*@{ */
-	int open_count;			/**< Outstanding files open, protected by drm_global_mutex. */
-	spinlock_t buf_lock;		/**< For drm_device::buf_use and a few other things. */
-	int buf_use;			/**< Buffers in use -- cannot alloc */
-	atomic_t buf_alloc;		/**< Buffer allocation in progress */
-	/*@} */
+	/** @buf_alloc: Buffer allocation in progress */
+	atomic_t buf_alloc;
 
 	struct mutex filelist_mutex;
 	struct list_head filelist;
@@ -87,51 +130,64 @@ struct drm_device {
 	/**
 	 * @filelist_internal:
 	 *
-	 * List of open DRM files for in-kernel clients. Protected by @filelist_mutex.
+	 * List of open DRM files for in-kernel clients.
+	 * Protected by &filelist_mutex.
 	 */
 	struct list_head filelist_internal;
 
 	/**
 	 * @clientlist_mutex:
 	 *
-	 * Protects @clientlist access.
+	 * Protects &clientlist access.
 	 */
 	struct mutex clientlist_mutex;
 
 	/**
 	 * @clientlist:
 	 *
-	 * List of in-kernel clients. Protected by @clientlist_mutex.
+	 * List of in-kernel clients. Protected by &clientlist_mutex.
 	 */
 	struct list_head clientlist;
 
-	/** \name Memory management */
-	/*@{ */
-	struct list_head maplist;	/**< Linked list of regions */
-	struct drm_open_hash map_hash;	/**< User token hash table for maps */
+	/** @maplist: Memory management - linked list of regions */
+	struct list_head maplist;
 
-	/** \name Context handle management */
-	/*@{ */
-	struct list_head ctxlist;	/**< Linked list of context handles */
-	struct mutex ctxlist_mutex;	/**< For ctxlist */
+	/** @map_hash: Memory management - user token hash table for maps */
+	struct drm_open_hash map_hash;
 
-	struct idr ctx_idr;
+	/**
+	 * @ctxlist:
+	 * Context handle management - linked list of context handles
+	 */
+	struct list_head ctxlist;
 
-	struct list_head vmalist;	/**< List of vmas (for debugging) */
+	/**
+	 * @ctxlist_mutex:
+	 *
+	 * Context handle management - mutex for &ctxlist
+	 */
+	struct mutex ctxlist_mutex;
 
-	/*@} */
+	/**
+	 * @ctx_idr:
+	 * Context handle management
+	 */
+	struct idr ctx_idr;
 
-	/** \name DMA support */
-	/*@{ */
-	struct drm_device_dma *dma;		/**< Optional pointer for DMA support */
-	/*@} */
+	/**
+	 * @vmalist:
+	 * Context handle management - list of vmas (for debugging)
+	 */
+	struct list_head vmalist;
+
+	/** @dma: Optional pointer for DMA support */
+	struct drm_device_dma *dma;
 
-	/** \name Context support */
-	/*@{ */
+	/** @context_flag: Context swapping flag */
+	__volatile__ long context_flag;
 
-	__volatile__ long context_flag;	/**< Context swapping flag */
-	int last_context;		/**< Last current context */
-	/*@} */
+	/** @last_context: Last current context */
+	int last_context;
 
 	/**
 	 * @irq_enabled:
@@ -168,7 +224,12 @@ struct drm_device {
 	 */
 	struct drm_vblank_crtc *vblank;
 
-	spinlock_t vblank_time_lock;    /**< Protects vblank count and time updates during vblank enable/disable */
+	/**
+	 * @vblank_time_lock:
+	 *
+	 *  Protects vblank count and time updates during vblank enable/disable
+	 */
+	spinlock_t vblank_time_lock;
 	spinlock_t vbl_lock;
 
 	/**
@@ -186,25 +247,29 @@ struct drm_device {
 	 *
 	 * If non-zeor, &drm_crtc_funcs.get_vblank_counter must be set.
 	 */
-	u32 max_vblank_count;           /**< size of vblank counter register */
 
-	/**
-	 * List of events
-	 */
+	/** @max_vblank_count: Size of vblank counter register */
+	u32 max_vblank_count;
+
+	/** @vblank_event_list: List of vblank events */
 	struct list_head vblank_event_list;
 	spinlock_t event_lock;
 
-	/*@} */
+	/** @agp: AGP data */
+	struct drm_agp_head *agp;
 
-	struct drm_agp_head *agp;	/**< AGP data */
+	/** @pdev: PCI device structure */
+	struct pci_dev *pdev;
 
-	struct pci_dev *pdev;		/**< PCI device structure */
 #ifdef __alpha__
 	struct pci_controller *hose;
 #endif
 
-	struct drm_sg_mem *sg;	/**< Scatter gather memory */
-	unsigned int num_crtcs;                  /**< Number of CRTCs on this device */
+	/** @sg: Scatter gather memory */
+	struct drm_sg_mem *sg;
+
+	/** @num_crtcs: Number of CRTCs on this device */
+	unsigned int num_crtcs;
 
 	struct {
 		int context;
@@ -214,14 +279,18 @@ struct drm_device {
 	struct drm_local_map *agp_buffer_map;
 	unsigned int agp_buffer_token;
 
-	struct drm_mode_config mode_config;	/**< Current mode config */
+	/** @mode_config: Current mode config */
+	struct drm_mode_config mode_config;
 
-	/** \name GEM information */
-	/*@{ */
+	/** @object_name_lock: GEM information */
 	struct mutex object_name_lock;
+
+	/** @object_name_idr: GEM information */
 	struct idr object_name_idr;
+
+	/** @vma_offset_manager: GEM information */
 	struct drm_vma_offset_manager *vma_offset_manager;
-	/*@} */
+
 	int switch_power_state;
 
 	/**
-- 
2.12.0

