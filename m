Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x2241fpy+x5DC+ENkGUKH1zb7SWusYOAy4gkHGryvyMh6qbmOYWbhXDnRx9xHR2/8rLANORUn
ARC-Seal: i=1; a=rsa-sha256; t=1518709088; cv=none;
        d=google.com; s=arc-20160816;
        b=vVcLZxzrIX0Vd0K19LQES3JUMS7+ay6B7R31mnZN60R3730F/nMJLr0SGy8mkTICe8
         pWntfvivuweI2s5thBVcOxfsj7RGTaDEnyyG6HC0hfUBi2CoY9DqiGjCybeb40zYItn8
         IMK5tiBZvcHdbiJ0HZrcJNi3omk73ZS2TNcHkbQDGyD8reVLkVbXekxdwG09oaw2M8P3
         TDrmksEHMF4sNyodu/bimcEYDzJXbhJDXJQdVOIKLJggoc43Ck0wOhPe66EbkXQuVhGr
         aPZOOhGk/N8A+HcsRCgE3ATfAoP5sAnwnIa1YrToieVtR5I6HAOd1/fEJTG+Rm6VnvJ9
         RbKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=H0fcbZAcAI6xQTZPGZauzxC28RSyr5IuziZfR+rTHUY=;
        b=tz+oTXE3zV7WQ2q9qdsdLTGvADPs8eZe4fgwlBrlTiBPH8HjWKsuGJhvWpas5maETS
         8fbxalpyXjXes1oJ/J10/Ro3r2tw1Bsz+vBeYYVJg4LZigo6jEhgXgkNysk5A6i2uFfO
         fsHL1AEoVzO+uqUD+mMlqXmzzTV1ApMR/2Qc0kP3rsGyU8A1tdvQH7zAio2kfuVlK0BJ
         ofbcclTaPt5G+E7T+U0uZQxrC8cUIHO+qDls8XoPbhmsYwhxlaypFqTyRGqXctCiLbGa
         1qH7KFW5uW5v4Q8eQ6e2hgpIBtH0etkl+kC3PZApqZJV2bELs1IoFm9y+wbuP3Q7BENk
         xBYg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Toshi Kani <toshi.kani@hpe.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH 4.14 187/195] acpi, nfit: fix register dimm error handling
Date: Thu, 15 Feb 2018 16:17:58 +0100
Message-Id: <20180215151715.639730018@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151705.738773577@linuxfoundation.org>
References: <20180215151705.738773577@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592481345316957816?=
X-GMAIL-MSGID: =?utf-8?q?1592481901264682552?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Toshi Kani <toshi.kani@hpe.com>

commit 23fbd7c70aec7600e3227eb24259fc55bf6e4881 upstream.

A NULL pointer reference kernel bug was observed when
acpi_nfit_add_dimm() called in acpi_nfit_register_dimms() failed. This
error path does not set nfit_mem->nvdimm, but the 2nd
list_for_each_entry() loop in the function assumes it's always set. Add
a check to nfit_mem->nvdimm.

Fixes: ba9c8dd3c222 ("acpi, nfit: add dimm device notification support")
Signed-off-by: Toshi Kani <toshi.kani@hpe.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/acpi/nfit/core.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/acpi/nfit/core.c
+++ b/drivers/acpi/nfit/core.c
@@ -1618,6 +1618,9 @@ static int acpi_nfit_register_dimms(stru
 		struct kernfs_node *nfit_kernfs;
 
 		nvdimm = nfit_mem->nvdimm;
+		if (!nvdimm)
+			continue;
+
 		nfit_kernfs = sysfs_get_dirent(nvdimm_kobj(nvdimm)->sd, "nfit");
 		if (nfit_kernfs)
 			nfit_mem->flags_attr = sysfs_get_dirent(nfit_kernfs,
