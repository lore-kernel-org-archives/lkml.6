Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S939419AbeE1OvW (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 10:51:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:48036 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S937210AbeE1K2j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:28:39 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Corey Minyard <cminyard@mvista.com>,
        Corey Minyard <minyard@acm.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 056/329] device property: Define type of PROPERTY_ENRTY_*() macros
Date: Mon, 28 May 2018 11:59:45 +0200
Message-Id: <20180528100247.335545382@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100241.796630982@linuxfoundation.org>
References: <20180528100241.796630982@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

[ Upstream commit c505cbd45f6e9c539d57dd171d95ec7e5e9f9cd0 ]

Some of the drivers may use the macro at runtime flow, like

  struct property_entry p[10];
...
  p[index++] = PROPERTY_ENTRY_U8("u8 property", u8_data);

In that case and absence of the data type compiler fails the build:

drivers/char/ipmi/ipmi_dmi.c:79:29: error: Expected ; at end of statement
drivers/char/ipmi/ipmi_dmi.c:79:29: error: got {

Acked-by: Corey Minyard <cminyard@mvista.com>
Cc: Corey Minyard <minyard@acm.org>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/property.h |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -187,7 +187,7 @@ struct property_entry {
  */
 
 #define PROPERTY_ENTRY_INTEGER_ARRAY(_name_, _type_, _val_)	\
-{								\
+(struct property_entry) {					\
 	.name = _name_,						\
 	.length = ARRAY_SIZE(_val_) * sizeof(_type_),		\
 	.is_array = true,					\
@@ -205,7 +205,7 @@ struct property_entry {
 	PROPERTY_ENTRY_INTEGER_ARRAY(_name_, u64, _val_)
 
 #define PROPERTY_ENTRY_STRING_ARRAY(_name_, _val_)		\
-{								\
+(struct property_entry) {					\
 	.name = _name_,						\
 	.length = ARRAY_SIZE(_val_) * sizeof(const char *),	\
 	.is_array = true,					\
@@ -214,7 +214,7 @@ struct property_entry {
 }
 
 #define PROPERTY_ENTRY_INTEGER(_name_, _type_, _val_)	\
-{							\
+(struct property_entry) {				\
 	.name = _name_,					\
 	.length = sizeof(_type_),			\
 	.is_string = false,				\
@@ -231,7 +231,7 @@ struct property_entry {
 	PROPERTY_ENTRY_INTEGER(_name_, u64, _val_)
 
 #define PROPERTY_ENTRY_STRING(_name_, _val_)		\
-{							\
+(struct property_entry) {				\
 	.name = _name_,					\
 	.length = sizeof(_val_),			\
 	.is_string = true,				\
@@ -239,7 +239,7 @@ struct property_entry {
 }
 
 #define PROPERTY_ENTRY_BOOL(_name_)		\
-{						\
+(struct property_entry) {			\
 	.name = _name_,				\
 }
 
