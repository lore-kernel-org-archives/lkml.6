Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49scsNaJ+/1/6k24po9l3AvyEiQbgfefHFDvv3a9tnEnzIPjYBJi1yhvX3T3/Zm36O07Ysm
ARC-Seal: i=1; a=rsa-sha256; t=1524652843; cv=none;
        d=google.com; s=arc-20160816;
        b=ToEWCelLw5l1x2IDeVB+nJmJ2ggymyjz5NNnLBTx6WJoOBEXROoxefZgBmaucI8VCZ
         CzGM3RHOmfcMT+SNKtN9yKNt5nnqyAGIo3rCkjFlIUYjJxp9MJ+pkcYa9+JXhMOZ0KUX
         TJQfrQnHWqivK8HTDazcLNbJBL5FBVAgw9anquVSKgL1/KypuAymM+/9v6O7dqfN173E
         gGBz1Qp2ZbEqrs6BFkkpmnxBFdSDvEAEOZuvLxSUFhwLs3tRdRtzFSkA3VGKtC77zkDE
         yGn197u1EV/w04IKMJLpXXBTb5MJSD45IY3zMwMw+qYlHyrg43H1eUCmLC+tkJFSK+tB
         OO0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=T7GnwjqG0GHcSLIJQmtifejIkGgYi/cv4bEvRqNPtds=;
        b=vM4pgJA4uJL8+z9+L4yEr2YaI3NI7sigDertZlTA0jWRFSVNBaVSnNiOXqqaqTe6wR
         NKQLe/ZQkVw0NjnkoX9wxC0r84hAI3TOPhiS3m0nY0HvxQkuAH3/MqDlX8yhj14pkzZm
         eYNUo5I0btR16eoKsAL+dTF3Z/8y/touB1IDUBSf+1ADhZEG/r8NM93AsaLfjkzERB+v
         2YpFawbg5uCsP/GEgVd4qc2moMjDvCt7Dt2zFcvf2Gyhg2QR7r1LzH4tbF6qXMXuPTL6
         H7wo6Zstay6w+wHhbOrtFpACQl7wepuh5y9L6jh+LSjqYKJ90fkKixKmWaH0F+3uuoum
         acWQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Corey Minyard <cminyard@mvista.com>,
	Corey Minyard <minyard@acm.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 089/183] device property: Define type of PROPERTY_ENRTY_*() macros
Date: Wed, 25 Apr 2018 12:35:09 +0200
Message-Id: <20180425103246.065508027@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180425103242.532713678@linuxfoundation.org>
References: <20180425103242.532713678@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598714379737614000?=
X-GMAIL-MSGID: =?utf-8?q?1598714379737614000?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/property.h |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -206,7 +206,7 @@ struct property_entry {
  */
 
 #define PROPERTY_ENTRY_INTEGER_ARRAY(_name_, _type_, _val_)	\
-{								\
+(struct property_entry) {					\
 	.name = _name_,						\
 	.length = ARRAY_SIZE(_val_) * sizeof(_type_),		\
 	.is_array = true,					\
@@ -224,7 +224,7 @@ struct property_entry {
 	PROPERTY_ENTRY_INTEGER_ARRAY(_name_, u64, _val_)
 
 #define PROPERTY_ENTRY_STRING_ARRAY(_name_, _val_)		\
-{								\
+(struct property_entry) {					\
 	.name = _name_,						\
 	.length = ARRAY_SIZE(_val_) * sizeof(const char *),	\
 	.is_array = true,					\
@@ -233,7 +233,7 @@ struct property_entry {
 }
 
 #define PROPERTY_ENTRY_INTEGER(_name_, _type_, _val_)	\
-{							\
+(struct property_entry) {				\
 	.name = _name_,					\
 	.length = sizeof(_type_),			\
 	.is_string = false,				\
@@ -250,7 +250,7 @@ struct property_entry {
 	PROPERTY_ENTRY_INTEGER(_name_, u64, _val_)
 
 #define PROPERTY_ENTRY_STRING(_name_, _val_)		\
-{							\
+(struct property_entry) {				\
 	.name = _name_,					\
 	.length = sizeof(_val_),			\
 	.is_string = true,				\
@@ -258,7 +258,7 @@ struct property_entry {
 }
 
 #define PROPERTY_ENTRY_BOOL(_name_)		\
-{						\
+(struct property_entry) {			\
 	.name = _name_,				\
 }
 
